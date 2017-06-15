module Conreality
  ##
  # Represents a Conreality asset.
  class Asset < Object
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
    # @param uuid   [#to_s]
    # @param client [Client]
    def initialize(uuid, client)
      super(uuid, client)
    end
  end # Asset
end # Conreality
