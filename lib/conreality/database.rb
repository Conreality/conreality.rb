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
      # @param name [Symbol] the attribute name
      # @return [void]
      def self.attr_reader(name)
        var = :"@#{name}"
        self.send(:define_method, name) do
          if self.instance_variable_defined?(var)
            self.instance_variable_get(var)
          else
            self.get(name)
          end
        end
      end

      ##
      # @param name [Symbol] the attribute name
      # @return [void]
      def self.attr_writer(name)
        var = :"@#{name}"
        self.send(:define_method, "#{name}=") do |value|
          self.set!(name, value)
          if self.instance_variable_defined?(var)
            self.instance_variable_set(var, value)
          end
        end
      end

      ##
      # @param name [Symbol] the attribute name
      # @return [void]
      def self.attr_accessor(name)
        self.attr_reader(name)
        self.attr_writer(name)
      end

      ##
      # @param name [Symbol] the attribute name
      # @return [void]
      def self.attr_binary(name)
        var = :"@#{name}"
        self.send(:define_method, name) do
          binary_id = self.get(name)
          binary_id ? Binary.new(@client, binary_id) : nil
        end
        self.send(:define_method, "#{name}=") do |binary_id|
          case binary_id
            when Binary
              self.set!(name, binary_id.id)
            else # Integer
              self.set!(name, binary_id.to_i)
          end
        end
      end

      ##
      # Fetches the value of a field.
      #
      # @param name [Symbol]
      # @param default [String, Numeric, nil]
      # @return [any]
      def get(name, default = nil)
        table = self.class.const_get(:TABLE)
        key_attr = self.class.const_get(:KEY)
        key = self.instance_variable_get(:"@#{key_attr}")
        @client.exec_with_params("SELECT #{q(name)} FROM public.#{q(table)} WHERE #{q(key_attr)} = $1 LIMIT 1", key) do |result|
          result.num_tuples.zero? ? default : result.getvalue(0, 0)
        end
      end

      ##
      # Updates the value of a field.
      #
      # @param name  [Symbol]
      # @param value [String, Numeric, nil]
      # @return [void]
      def set!(name, value)
        # TODO
      end

    private

      def q(s); @client.conn.quote_ident(s.to_s); end
    end # Row
  end # Database
end # Conreality
