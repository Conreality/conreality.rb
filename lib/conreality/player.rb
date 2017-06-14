module Conreality
  ##
  # Represents a Conreality player.
  class Player < Object
    ##
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
      super(uuid, client)
    end
  end # Player
end # Conreality
