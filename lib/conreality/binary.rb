# This is free and unencumbered software released into the public domain.

module Conreality
  ##
  # Represents a Conreality binary.
  class Binary #< Database::Row
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
    # @param session [Session]
    # @param id      [#to_i]
    def initialize(session, id)
      super(session)
      @id = id.to_i
    end

    ##
    # Returns a developer-friendly representation of this binary.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x(id: %s)>", self.class.name, self.__id__, @id)
    end
  end # Binary
end # Conreality
