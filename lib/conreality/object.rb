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
  end # Object
end # Conreality
