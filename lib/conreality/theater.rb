module Conreality
  ##
  # Represents a Conreality theater of operations.
  class Theater < Database::Row
    TABLE = :theater
    KEY   = :uuid

    ##
    # The theater's unique identifier.
    #
    # @return [String]
    attr_reader :uuid

    ##
    # The theater's designated label.
    #
    # @return [String]
    attr_accessor :label

    ##
    # The theater's origin location (as GPS coordinates).
    #
    # @return [?]
    attr_accessor :location

    ##
    # @param client [Client]
    # @param uuid   [#to_s]
    def initialize(client, uuid)
      super(client)
      @uuid = uuid.to_s
    end

    ##
    # @todo
    def each_object(&block)
      # TODO
    end
  end # Theater
end # Conreality
