module Conreality
  ##
  # Represents a Conreality client session.
  class Session
    ##
    # @param client [Client]
    def initialize(client)
      @client = client
    end

    ##
    # Returns a developer-friendly representation of this session.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x>", self.class.name, self.__id__)
    end

    ##
    # Starts this session.
    #
    # @return [void]
    def start!
      @client.call_proc_with_result(:session_start, cast: :text)
    end

    ##
    # Terminates this session.
    #
    # @return [void]
    def terminate!
      @client.call_proc_with_result(:session_terminate, cast: :text)
    end
  end # Session
end # Conreality
