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
    # @param  proc_name [#to_s]
    # @param  args [Array]
    # @param  cast [#to_s, nil]
    # @return [any]
    def call_proc_with_result(proc_name, args: [], cast: nil)
      self.call_proc_by_name(proc_name, args: args, cast: cast) do |results|
        results.getvalue(0, 0)
      end
    end

    ##
    # @param  proc_name [#to_s]
    # @param  args [Array]
    # @param  cast [#to_s, nil]
    # @return [any]
    def call_proc_by_name(proc_name, args: [], cast: nil, &block)
      proc_sig = "#{q(Database::SCHEMA)}.#{q(proc_name)}("
      case args
        when Array
          proc_sig << 1.upto(args.size).map { |i| "$#{i}" }.join(', ') unless args.empty?
        when Hash
          raise TypeError # TODO
        else raise TypeError
      end
      proc_sig << ")"
      self.call_proc_by_signature(proc_sig, args: args, cast: cast, &block)
    end

    ##
    # @param  proc_sig [#to_s]
    # @param  args [Array]
    # @param  cast [#to_s, nil]
    # @return [any]
    def call_proc_by_signature(proc_sig, args: [], cast: nil, &block)
      query_body = cast ? "#{proc_sig}::#{cast}" : proc_sig.to_s
      self.exec_with_params("SELECT #{query_body}", *args, &block)
    end

    ##
    # @param  query [String]
    # @param  args [Array]
    # @return [PG::Result]
    def exec_with_params(query, *args, &block)
      @conn.exec_params(query, args, 0, &block)
    end

    # @!endgroup

  private

    def q(s); @conn.quote_ident(s.to_s); end
  end # Client
end # Conreality
