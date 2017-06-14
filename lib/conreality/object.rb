module Conreality
  ##
  # Represents a Conreality object.
  class Object
    # @return [String] the object's UUID
    attr_reader :uuid

    ##
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
      @uuid, @client = uuid.to_s, client
    end
  end # Object
end # Conreality
