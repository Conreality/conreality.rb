module Conreality
  ##
  module Database
    ##
    # Represents a database row.
    class Row
      ##
      # The table this database row belongs to.
      #
      # @return [String]
      attr_reader :table

      ##
      # The primary key for this database row.
      #
      # @return [Symbol]
      attr_reader :key

      ##
      # @param table [String]
      # @param key   [Symbol]
      def initialize(table, key)
        @table, @key = table.to_s, key.to_sym
      end
    end
  end # Database
end # Conreality
