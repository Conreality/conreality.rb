# This is free and unencumbered software released into the public domain.

module Conreality
  ##
  # Represents a Conreality event.
  class Event
    TABLE = :event
    KEY   = :id

    ##
    # The event's sequential identifier.
    #
    # @return [Integer]
    attr_reader :id

    ##
    # The event's timestamp (in Zulu time).
    #
    # @return [Time]
    attr_reader :timestamp

    ##
    # The event's predicate (an action or verb).
    #
    # @return [Symbol]
    attr_reader :predicate

    ##
    # The subject (i.e., source) of the predicate.
    #
    # @return [Object]
    attr_reader :subject
    #attr_wrapper :subject, :Object

    ##
    # The object (i.e., target) of the predicate.
    #
    # @return [Object]
    attr_reader :object
    #attr_wrapper :object, :Object

    ##
    # @param session [Session]
    # @param id      [#to_i]
    def initialize(session, id)
      @session, @id = session, id.to_i
    end

    ##
    # Returns a developer-friendly representation of this event.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x(id: %s)>", self.class.name, self.__id__, @id)
    end
  end # Event
end # Conreality
