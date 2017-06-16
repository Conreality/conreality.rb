module Conreality
  ##
  # Represents a Conreality camera.
  class Camera < Object
    TABLE = :camera
    KEY   = :uuid

    ##
    # The camera's resolution (in 2D pixels).
    #
    # @return [Array(Integer, Integer)]
    attr_reader :resolution

    ##
    # The camera's image format.
    #
    # @return [String]
    attr_reader :format

    ##
    # The camera's frame rate (per second).
    #
    # @return [Integer]
    attr_reader :fps

    ##
    # The camera's f-number (the f/N focal ratio).
    #
    # @return [Integer]
    attr_reader :fnumber

    ##
    # @param client [Client]
    # @param uuid   [#to_s]
    def initialize(client, uuid)
      super(client, uuid)
    end
  end # Camera
end # Conreality
