module Conreality
  ##
  # Represents a Conreality message.
  class Message
    ##
    # The message's sequential identifier.
    #
    # @return [Integer]
    attr_reader :id

    ##
    # The message's timestamp (in Zulu time).
    #
    # @return [Date]
    attr_reader :timestamp

    ##
    # The sender of the message.
    #
    # @return [Player, Asset]
    attr_reader :sender

    ##
    # The message's contents as text.
    #
    # @return [String]
    attr_reader :text

    ##
    # The message's contents as audio.
    #
    # @return [Binary]
    attr_reader :audio

    ##
    # @param id     [#to_i]
    # @param client [Client]
    def initialize(id, client)
      @id, @client = id.to_i, client
    end
  end # Message
end # Conreality
