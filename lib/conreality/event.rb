module Conreality
  ##
  # Represents a Conreality event.
  class Event
    ##
    # The event's sequential identifier.
    #
    # @return [Integer]
    attr_reader :id

    ##
    # The event's timestamp (in Zulu time).
    #
    # @return [Date]
    attr_reader :timestamp

    ##
    # The event's predicate (an action or verb).
    #
    # @return [String]
    attr_reader :predicate

    ##
    # The subject (i.e., source) of the predicate.
    #
    # @return [Object]
    attr_reader :subject

    ##
    # The object (i.e., target) of the predicate.
    #
    # @return [Object]
    attr_reader :object

    ##
    # @param id     [#to_i]
    # @param client [Client]
    def initialize(id, client)
      @id, @client = id.to_i, client
    end
  end # Event
end # Conreality
