require 'pg'

module Conreality
  ##
  # Client for accessing a Conreality master server.
  class Client
    # @return [PG::Connection]
    attr_accessor :conn

    ##
    # @param [Hash] options
    def initialize(options = {})
      @conn = PG.connect(options)
    end
  end # module
end # module
