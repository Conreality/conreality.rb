module Conreality
  ##
  # Represents a Conreality asset.
  class Asset < Object
    ##
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
      super(uuid, client)
    end
  end # Asset
end # Conreality
