module Conreality
  ##
  # Represents a Conreality object.
  class Object < Database::Row
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
    attr_reader :theater

    ##
    # The group, if any, that the object belongs to.
    #
    # @return [Group]
    attr_reader :group

    ##
    # The object's designated label.
    #
    # @return [String]
    attr_reader :label

    ##
    # The object's current position (as 3D coordinates relative to its theater).
    #
    # @return [?]
    attr_reader :position

    ##
    # The object's current orientation (in radians relative to north).
    #
    # @return [Float]
    attr_reader :orientation

    ##
    # The object's estimated mass (in kilograms).
    #
    # @return [Float]
    attr_reader :mass

    ##
    # The object's determined radius (in meters).
    #
    # @return [Float]
    attr_reader :radius

    ##
    # The object's estimated color (as a 24-bit RGB value).
    #
    # @return [Integer]
    attr_reader :color

    ##
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
      super(:uuid)
      @uuid, @client = uuid.to_s, client
    end

    # @!group Casts

    ##
    # Returns this object cast to an asset.
    #
    # @return [Asset]
    def as_asset
      Asset.new(@uuid, @client)
    end

    ##
    # Returns this object cast to a camera.
    #
    # @return [Camera]
    def as_camera
      Camera.new(@uuid, @client)
    end

    ##
    # Returns this object cast to a player.
    #
    # @return [Player]
    def as_player
      Player.new(@uuid, @client)
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
