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
    # Starts this session.
    #
    # @return [void]
    def start!
      @client.call_proc_with_result('public.session_start()::text')
    end

    ##
    # Terminates this session.
    #
    # @return [void]
    def terminate!
      @client.call_proc_with_result('public.session_terminate()::text')
    end
  end # Session
end # Conreality
