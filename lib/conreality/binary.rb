module Conreality
  ##
  # Represents a Conreality binary.
  class Binary < Database::Row
    TABLE = :binary
    KEY   = :id

    ##
    # The binary's sequential identifier.
    #
    # @return [Integer]
    attr_reader :id

    ##
    # The binary's unique identifier (SHA-256 fingerprint).
    #
    # @return [String]
    attr_reader :sha256

    ##
    # The binary's MIME content type.
    #
    # @return [String]
    attr_accessor :type

    ##
    # The binary data.
    #
    # @return [String]
    attr_reader :data

    ##
    # @param client [Client]
    # @param id     [#to_i]
    def initialize(client, id)
      super(client)
      @id = id.to_i
    end
  end # Binary
end # Conreality
