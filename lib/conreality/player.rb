module Conreality
  ##
  # Represents a Conreality player.
  class Player < Object
    TABLE = :object_player
    KEY   = :uuid

    ##
    # The player's nickname.
    #
    # @return [String]
    attr_accessor :nick

    ##
    # The player's full name.
    #
    # @return [String]
    attr_accessor :name

    ##
    # The player's IPv4/IPv6 address.
    #
    # @return [String]
    attr_accessor :ip_addr

    ##
    # The player's avatar image.
    #
    # @return [Binary]
    attr_accessor :avatar
    attr_binary   :avatar

    ##
    # The player's primary language.
    #
    # @return [String]
    attr_accessor :language

    ##
    # @param client [Client]
    # @param uuid   [#to_s]
    def initialize(client, uuid)
      super(client, uuid)
    end

    ##
    # Checks whether this player has a bodycam.
    #
    # @return [Boolean]
    def has_camera?
      nil # TODO
    end

    ##
    # Deregisters this player from the game.
    #
    # @return [void]
    def deregister!
      # TODO
    end
  end # Player
end # Conreality
