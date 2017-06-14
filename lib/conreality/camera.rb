module Conreality
  ##
  # Represents a Conreality camera.
  class Camera < Object
    ##
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
      super(uuid, client)
    end
  end # Camera
end # Conreality
