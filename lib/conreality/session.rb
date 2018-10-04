# This is free and unencumbered software released into the public domain.

module Conreality
  ##
  # An authenticated session.
  class Session
    ##
    # The client connection this session belongs to.
    #
    # @return [Client]
    attr_reader :client

    ##
    # @param client [Client]
    def initialize(client)
      @client = client
      @client.call_proc_with_result(:session_start, cast: :text)
    end

    ##
    # Returns a developer-friendly representation of this session.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x>", self.class.name, self.__id__)
    end

    ##
    # Terminates this session.
    #
    # @return [void]
    def logout!
      @client.call_proc_with_result(:session_terminate, cast: :text)
      @client = nil
    end

    ##
    # TODO
    #
    # @return [Game]
    def game
      Game.new(self)
    end

    # @!group Action execution

    ##
    # @yield  [action]
    # @yieldparam  action [Action]
    # @yieldreturn [void]
    # @return [void]
    def execute(&block)
      action = Action.new(self)
      if @client.connection.transaction_status.zero?
        # not yet in transaction scope
        @client.connection.transaction { |_| block.call(action) }
      else
        # already in transaction scope
        block.call(action)
      end
    end

    # @!endgroup
  end # Session
end # Conreality
