# This is free and unencumbered software released into the public domain.

module Conreality
  ##
  # Represents a Conreality asset.
  class Asset < Object
    TABLE = :object_asset
    KEY   = :uuid

    ##
    # The asset's nickname.
    #
    # @return [String]
    attr_accessor :nick

    ##
    # The asset's full name.
    #
    # @return [String]
    attr_accessor :name

    ##
    # The asset's IPv4/IPv6 address.
    #
    # @return [String]
    attr_accessor :ip_addr

    ##
    # The asset's avatar image.
    #
    # @return [Binary]
    attr_accessor :avatar
    attr_wrapper :avatar, :Binary

    ##
    # The asset's deployed software version.
    #
    # @return [String]
    attr_accessor :version

    ##
    # @param session [Session]
    # @param uuid    [#to_s]
    def initialize(session, uuid)
      super(session, uuid)
    end
  end # Asset
end # Conreality
