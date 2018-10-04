# This is free and unencumbered software released into the public domain.

require 'conreality/rpc'
require 'uuid'

module Conreality
  ##
  # Client for accessing a Conreality master server.
  class Client
    ##
    # @param master_host [String]
    def initialize(master_host)
      @public = Conreality::RPC::Public::Stub.new(master_host, :this_channel_is_insecure)
    end

    ##
    # Returns a developer-friendly representation of this client.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x>", self.class.name, self.__id__)
    end

    # @!group Connection management

    ##
    # TODO
    #
    # @return [void]
    def disconnect!
      @public = nil
    end

    # @!endgroup

    # @!group Session interface

    ##
    # TODO
    #
    # @param  agent_uuid [String]
    # @param  secret [String]
    # @return [Session]
    def login(agent_uuid, secret = nil)
      Session.new(self) # TODO
    end

    # @!endgroup

  private

    # TODO
  end # Client
end # Conreality
