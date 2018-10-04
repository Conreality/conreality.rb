# This is free and unencumbered software released into the public domain.

module Conreality
  ##
  # Represents a Conreality camera.
  class Camera < Object
    TABLE = :object_camera
    KEY   = :uuid

    ##
    # The camera's resolution (in 2D pixels).
    #
    # @return [Array(Integer, Integer)]
    attr_accessor :resolution

    ##
    # The camera's image format.
    #
    # @return [String]
    attr_accessor :format

    ##
    # The camera's frame rate (per second).
    #
    # @return [Integer]
    attr_accessor :fps

    ##
    # The camera's f-number (the f/N focal ratio).
    #
    # @return [Integer]
    attr_accessor :fnumber

    ##
    # @param session [Session]
    # @param uuid    [#to_s]
    def initialize(session, uuid)
      super(session, uuid)
    end
  end # Camera
end # Conreality
