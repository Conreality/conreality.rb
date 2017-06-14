module Conreality
  ##
  # Represents a Conreality message.
  class Message
    # @return [Integer] the message's ID
    attr_reader :id

    ##
    # @param id     [#to_i]
    # @param client [Client]
    def initialize(id, client)
      @id, @client = id.to_i, client
    end
  end # Message
end # Conreality
