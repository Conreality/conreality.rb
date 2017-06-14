module Conreality
  ##
  # Represents a Conreality event.
  class Event
    # @return [Integer] the event's ID
    attr_reader :id

    ##
    # @param id     [#to_i]
    # @param client [Client]
    def initialize(id, client)
      @id, @client = id.to_i, client
    end
  end # Event
end # Conreality
