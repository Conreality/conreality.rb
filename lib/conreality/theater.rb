module Conreality
  ##
  # Represents a Conreality theater of operations.
  class Theater < Database::Row
    ##
    # The theater's unique identifier.
    #
    # @return [String]
    attr_reader :uuid

    ##
    # The theater's designated label.
    #
    # @return [String]
    attr_reader :label

    ##
    # The theater's origin location (as GPS coordinates).
    #
    # @return [?]
    attr_reader :location

    ##
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
      super('public.theater', :uuid)
      @uuid, @client = uuid.to_s, client
    end

    ##
    # @todo
    def each_object(&block)
      # TODO
    end
  end # Theater
end # Conreality
