# This is free and unencumbered software released into the public domain.

module Conreality
  ##
  # Represents a Conreality message.
  class Message
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
    # @return [Time]
    attr_reader :timestamp

    ##
    # The sender of the message.
    #
    # @return [Player, Asset]
    attr_reader :sender
    #attr_wrapper :sender, :Object

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
    #attr_wrapper :audio, :Binary

    ##
    # @param session [Session]
    # @param id      [#to_i]
    def initialize(session, id)
      @session, @id = session, id.to_i
    end

    ##
    # Returns a developer-friendly representation of this message.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x(id: %s)>", self.class.name, self.__id__, @id)
    end
  end # Message
end # Conreality
