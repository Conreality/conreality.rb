module Conreality
  ##
  # Represents a Conreality message.
  class Message < Database::Row
    TABLE = :message
    KEY   = :id

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
    attr_binary :audio

    ##
    # @param client [Client]
    # @param id     [#to_i]
    def initialize(client, id)
      super(client)
      @id = id.to_i
    end
  end # Message
end # Conreality
