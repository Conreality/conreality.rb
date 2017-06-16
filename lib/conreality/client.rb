require 'pg'
require 'uuid'

module Conreality
  ##
  # Client for accessing a Conreality master server.
  class Client
    ##
    # The PostgreSQL socket connection.
    #
    # @return [PG::Connection]
    attr_accessor :conn

    ##
    # The current session.
    #
    # @return [Session]
    attr_accessor :session

    ##
    # @param  options [Hash]
    # @option options [String] :dbname
    def initialize(options = {})
      @conn = PG.connect(options)
      @conn.type_map_for_results = PG::BasicTypeMapForResults.new(@conn)
      @session = Session.new(self)
      @session.start!
    end

    ##
    # Returns a developer-friendly representation of this client.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x>", self.class.name, self.__id__)
    end

    # @!group Database transactions

    ##
    # @yield  [transaction]
    # @yieldparam  transaction [Database::Transaction]
    # @yieldreturn [void]
    # @return [void]
    def open(&block)
      tx = Database::Transaction.new(self)
      if @conn.transaction_status.zero?
        # not yet in transaction scope
        @conn.transaction { |_| block.call(tx) }
      else
        # already in transaction scope
        block.call(tx)
      end
    end

    # @!endgroup

    # @!group Database interface

    ##
    # @param  signature [String]
    # @param  arguments [Array]
    # @return [::Object]
    def call_proc_with_result(signature, *arguments)
      self.call_proc(signature, *arguments) do |results|
        results.getvalue(0, 0)
      end
    end

    ##
    # @param  signature [String]
    # @param  arguments [Array]
    # @return [PG::Result]
    def call_proc(signature, *arguments, &block)
      exec_with_params("SELECT #{signature}", *arguments, &block)
    end

    ##
    # @param  query [String]
    # @param  arguments [Array]
    # @return [PG::Result]
    def exec_with_params(query, *arguments, &block)
      @conn.exec_params(query, arguments, 0, &block)
    end

    # @!endgroup
  end # Client
end # Conreality
