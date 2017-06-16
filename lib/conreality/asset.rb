module Conreality
  ##
  # Represents a Conreality asset.
  class Asset < Object
    TABLE = :asset
    KEY   = :uuid

    ##
    # The asset's nickname.
    #
    # @return [String]
    attr_reader :nick

    ##
    # The asset's full name.
    #
    # @return [String]
    attr_reader :name

    ##
    # The asset's IPv4/IPv6 address.
    #
    # @return [String]
    attr_reader :ip_addr

    ##
    # The asset's avatar image.
    #
    # @return [Binary]
    attr_reader :avatar

    ##
    # The asset's deployed software version.
    #
    # @return [String]
    attr_reader :version

    ##
    # @param client [Client]
    # @param uuid   [#to_s]
    def initialize(client, uuid)
      super(client, uuid)
    end
  end # Asset
end # Conreality
