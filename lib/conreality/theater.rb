module Conreality
  ##
  # Represents a Conreality theater of operations.
  class Theater
    # @return [String] the theater's UUID
    attr_reader :uuid

    ##
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
      @uuid, @client = uuid.to_s, client
    end

    ##
    # @todo
    def each_object(&block)
      # TODO
    end
  end # Theater
end # Conreality
