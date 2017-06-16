module Conreality
  ##
  # Represents a Conreality object.
  class Object < Database::Row
    TABLE = :object
    KEY   = :uuid

    ##
    # The object's unique identifier.
    #
    # @return [String]
    attr_reader :uuid

    ##
    # The object's type.
    #
    # @return [Symbol]
    attr_reader :type

    ##
    # The theater that the object is located in.
    #
    # @return [Theater]
    attr_accessor :theater

    ##
    # The group, if any, that the object belongs to.
    #
    # @return [Group]
    attr_accessor :group

    ##
    # The object's designated label.
    #
    # @return [String]
    attr_accessor :label

    ##
    # The object's current position (as 3D coordinates relative to its theater).
    #
    # @return [?]
    attr_accessor :position

    ##
    # The object's current orientation (in radians relative to north).
    #
    # @return [Float]
    attr_accessor :orientation

    ##
    # The object's estimated mass (in kilograms).
    #
    # @return [Float]
    attr_accessor :mass

    ##
    # The object's determined radius (in meters).
    #
    # @return [Float]
    attr_accessor :radius

    ##
    # The object's estimated color (as a 24-bit RGB value).
    #
    # @return [Integer]
    attr_accessor :color

    ##
    # @param client [Client]
    # @param uuid   [#to_s]
    def initialize(client, uuid)
      super(client)
      @uuid = uuid.to_s
    end

    # @!group Casts

    ##
    # Returns this object cast to an asset.
    #
    # @return [Asset]
    def as_asset
      Asset.new(@client, @uuid)
    end

    ##
    # Returns this object cast to a camera.
    #
    # @return [Camera]
    def as_camera
      Camera.new(@client, @uuid)
    end

    ##
    # Returns this object cast to a player.
    #
    # @return [Player]
    def as_player
      Player.new(@client, @uuid)
    end

    # @!endgroup

    # @!group Predicates

    ##
    # Checks whether this object is an asset.
    #
    # @return [Boolean]
    def is_asset?
      nil # TODO
    end

    ##
    # Checks whether this object is a camera.
    #
    # @return [Boolean]
    def is_camera?
      nil # TODO
    end

    ##
    # Checks whether this object is a player.
    #
    # @return [Boolean]
    def is_player?
      nil # TODO
    end

    ##
    # Checks whether this object is a target.
    #
    # @return [Boolean]
    def is_target?
      nil # TODO
    end

    # @!endgroup

    # @!group Messaging

    ##
    # @param  text      [String] the message contents as text
    # @return [Message] the sent message
    def send_message(text)
      @client.send_message(self, text)
    end

    # @!endgroup
  end # Object
end # Conreality
