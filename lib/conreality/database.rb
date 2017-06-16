module Conreality
  ##
  module Database
    ##
    # Represents a database row.
    class Row
      ##
      # @param client [Client]
      def initialize(client)
        @client = client
      end

      ##
      # Fetches the value of a field.
      #
      # @param name [Symbol]
      # @return [any]
      def fetch(name)
        table = self.class.const_get(:TABLE)
        key = self.class.const_get(:KEY)
        id = self.send(key)
        @client.exec_with_params("SELECT \"#{name}\" FROM public.\"#{table}\" WHERE \"#{key}\" = $1 LIMIT 1", id) do |result|
          result.num_tuples.zero? ? nil : result.getvalue(0, 0)
        end
      end

      ##
      # Fetches the value of a field.
      #
      # @param name  [Symbol]
      # @param value [any]
      # @return [void]
      def update!(name, value)
        # TODO
      end
    end
  end # Database
end # Conreality
