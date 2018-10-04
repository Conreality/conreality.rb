# This is free and unencumbered software released into the public domain.

module Conreality
  ##
  # The game database.
  class Game
    ##
    # @param session [Session]
    def initialize(session)
      @session = session
    end

    ##
    # Returns a developer-friendly representation of this action.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x>", self.class.name, self.__id__)
    end

    # @!group Theaters

    ##
    # Returns the theater identified by the given UUID.
    #
    # @param  uuid [String] the theater's UUID
    # @return [Theater] the theater
    def find_theater(uuid)
      Conreality::Theater.new(@session, uuid)
    end

    ##
    # @todo
    def each_theater(&block)
      # TODO
    end

    # @!endgroup

    # @!group Objects

    ##
    # Returns the object identified by the given UUID.
    #
    # @param  uuid [String] the object's UUID
    # @return [Object] the object
    def find_object(uuid)
      Conreality::Object.new(@session, uuid)
    end

    ##
    # @todo
    def each_object(&block)
      # TODO
    end

    # @!endgroup

    # @!group Events

    ##
    # @todo
    # @return [Event] the event
    def find_event(id)
      # TODO
    end

    # @!endgroup

    # @!group Messaging

    ##
    # @todo
    # @return [Message] the message
    def find_message(id)
      # TODO
    end

    # @!endgroup
  end # Game
end # Conreality
