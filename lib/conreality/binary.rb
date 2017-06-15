module Conreality
  ##
  # Represents a Conreality binary.
  class Binary
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
    attr_reader :type

    ##
    # The binary data.
    #
    # @return [String]
    attr_reader :data

    ##
    # @param id     [#to_i]
    # @param client [Client]
    def initialize(id, client)
      @id, @client = id.to_i, client
    end
  end # Binary
end # Conreality
