# This is free and unencumbered software released into the public domain.

require 'uuid'

require_relative 'rpc'
require_relative 'session'
require_relative 'version'

module Conreality
  ##
  # Client for accessing a Conreality master server.
  class Client
    attr_reader :rpc_public
    attr_reader :rpc_session

    ##
    # @param master_host [String]
    def self.connect(master_host, *args)
      self.new(master_host, *args).connect
    end

    ##
    # @param master_host [String]
    def initialize(master_host)
      channel_creds = :this_channel_is_insecure
      @channel      = RPC::Session::Stub.setup_channel(nil, master_host, channel_creds)
      @rpc_public   = RPC::Public::Stub.new(master_host, channel_creds, channel_override: @channel)
      @rpc_session  = RPC::Session::Stub.new(master_host, channel_creds, channel_override: @channel)
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
    # Connects to the server.
    #
    # @return [Client] `self`
    def connect
      self
    end

    ##
    # Disconnects from the server.
    #
    # @return [void]
    def disconnect!
      @channel = @rpc_public = @rpc_session = nil
    end

    # @!endgroup

    # @!group Public interface

    ##
    # Invokes the public `Authenticate` method on the server.
    #
    # @param  agent_uuid [String]
    # @param  secret [String]
    # @return [Session]
    def authenticate(agent_uuid, secret = nil)
      Session.new(self, 1) # TODO
    end

    ##
    # Invokes the public `Bye` method on the server.
    #
    # @return [void]
    def bye
      @rpc_public.bye(RPC::EmptyRequest.new)
    end

    ##
    # Invokes the public `Hello` method on the server.
    #
    # @return [Hash]
    def hello
      {version: @rpc_public.hello(RPC::HelloRequest.new(version: Conreality::VERSION.to_s)).version}.freeze
    end

    ##
    # Invokes the public `Ping` method on the server.
    #
    # @return [void]
    def ping
      @rpc_public.ping(RPC::PingRequest.new)
    end

    # @!endgroup

    # @!group Session interface

    # @!endgroup

  private

    # TODO
  end # Client
end # Conreality
