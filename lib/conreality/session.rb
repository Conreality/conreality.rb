# This is free and unencumbered software released into the public domain.

require_relative 'event'
require_relative 'game'
require_relative 'message'

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
    # The session ID.
    #
    # @return [Integer]
    attr_reader :id

    ##
    # @param client [Client]
    # @param id [Integer]
    def initialize(client, id)
      @client, @id = client, id.to_i
    end

    ##
    # Returns a developer-friendly representation of this session.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x>", self.class.name, self.__id__)
    end

    ##
    # Invokes the session-scoped `Ping` method on the server.
    #
    # @return [void]
    def ping
      @client.rpc_session.ping(RPC::PingRequest.new)
    end

    ##
    # Invokes the session-scoped `SendEvent` method on the server.
    #
    # @param  [String, #to_s] predicate
    # @param  [Object] subject
    # @param  [Object] object
    # @return [Event]
    def send_event(predicate, subject, object)
      response = @client.rpc_session.send_event(
        RPC::SendEventRequest.new(
          session_id: @id,
          predicate: predicate,
          subject: subject,
          object: object,
        )
      )
      Event.new(self, response.id)
    end

    ##
    # Invokes the session-scoped `SendMessage` method on the server.
    #
    # @param  [String, #to_s] text
    # @return [Message]
    def send_message(text)
      response = @client.rpc_session.send_message(
        RPC::SendMessageRequest.new(
          session_id: @id,
          text: text.to_s,
        )
      )
      Message.new(self, response.id)
    end

    ##
    # Invokes the session-scoped `UpdatePlayer` method on the server.
    #
    # @return [void]
    def update_player()
      @client.rpc_session.update_player(
        RPC::UpdatePlayerRequest.new(
          session_id: @id,
        )
      )
    end

    ##
    # Terminates this session.
    #
    # @return [void]
    def logout!
      # TODO
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
    def _execute(&block)
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
