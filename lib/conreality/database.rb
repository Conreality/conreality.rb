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
      # @return [Symbol]
      def self.table
        self.const_get(:TABLE)
      end

      ##
      # @return [Symbol]
      def self.key
        self.const_get(:KEY)
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
      # @param name       [Symbol] the attribute name
      # @param class_name [Class, Symbol] the class name
      # @return [void]
      def self.attr_wrapper(name, class_name)
        var = :"@#{name}"
        self.send(:define_method, name) do
          klass = find_class(class_name)
          key = self.get(name)
          key ? klass.new(@client, key) : nil
        end
        self.send(:define_method, "#{name}=") do |value|
          case value
            when Integer
              self.set!(name, value)
            when Database::Row
              klass = find_class(class_name)
              key_attr = klass.key
              key = value.instance_variable_get(:"@#{key_attr}")
              self.set!(name, key)
            else
              raise TypeError, "expected Integer or Database::Row, got #{value.inspect}"
          end
        end
      end

      ##
      # Returns the primary key for this row.
      #
      # @return [Integer, String]
      def key
        self.instance_variable_get(:"@#{self.class.key}").freeze
      end

      ##
      # Fetches the value of a field.
      #
      # @param name [Symbol]
      # @param default [String, Numeric, nil]
      # @return [any]
      def get(name, default = nil)
        table, key_attr, key = self.class.table, self.class.key, self.key
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
        table, key_attr, key = self.class.table, self.class.key, self.key
        p [:set!, name, value, table, key_attr, key] # TODO
      end

    private

      def q(s); @client.conn.quote_ident(s.to_s); end

      def find_class(class_name)
        case class_name
          when Class then class_name
          else self.class.const_get("Conreality::#{class_name}")
        end
      end
    end # Row
  end # Database
end # Conreality
