module Conreality
  ##
  # Represents a Conreality object.
  class Object
    # @return [String] the object's UUID
    attr_reader :uuid

    ##
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
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
    # @return [Integer] the message ID
    def send_message(text)
      @client.send_message(self, text)
    end

    # @!endgroup
  end # Object
end # Conreality
