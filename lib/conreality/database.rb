module Conreality
  ##
  module Database
    ##
    # Represents a database row.
    class Row
      ##
      # The primary key for this database row.
      #
      # @return [Symbol]
      attr_reader :key

      ##
      # @param key [Symbol]
      def initialize(key)
        @key = key.to_sym
      end
    end
  end # Database
end # Conreality
