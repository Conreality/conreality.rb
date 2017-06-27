module Conreality::Database
  ##
  # Encapsulates a database row.
  class Row
    SCHEMA = Conreality::Database::SCHEMA

    ##
    # @param session [Session]
    def initialize(session)
      @session = session
    end

    ##
    # @return [Symbol]
    def self.table_name
      self.const_get(:TABLE)
    end

    ##
    # @return [Symbol]
    def self.key_attr
      self.const_get(:KEY)
    end

    ##
    # @param attr_name [Symbol] the attribute name
    # @return [void]
    def self.attr_reader(attr_name)
      attr_var = :"@#{attr_name}"
      self.send(:define_method, attr_name) do
        if self.instance_variable_defined?(attr_var)
          self.instance_variable_get(attr_var)
        else
          self.get(attr_name)
        end
      end
    end

    ##
    # @param attr_name [Symbol] the attribute name
    # @return [void]
    def self.attr_writer(attr_name)
      attr_var = :"@#{attr_name}"
      self.send(:define_method, "#{attr_name}=") do |value|
        self.set!(attr_name, value)
        if self.instance_variable_defined?(attr_var)
          self.instance_variable_set(attr_var, value)
        end
      end
    end

    ##
    # @param attr_name [Symbol] the attribute name
    # @return [void]
    def self.attr_accessor(attr_name)
      self.attr_reader(attr_name)
      self.attr_writer(attr_name)
    end

    ##
    # @param attr_name  [Symbol] the attribute name
    # @param class_name [Class, Symbol] the class name
    # @return [void]
    def self.attr_wrapper(attr_name, class_name)
      self.send(:define_method, attr_name) do
        klass = find_class(class_name)
        key = self.get(attr_name)
        key ? klass.new(@session, key) : nil
      end
      self.send(:define_method, "#{attr_name}=") do |value|
        case value
          when Integer
            self.set!(attr_name, value)
          when Database::Row
            klass = find_class(class_name)
            key_attr = klass.key_attr
            key = value.instance_variable_get(:"@#{key_attr}")
            self.set!(attr_name, key)
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
      self.instance_variable_get(:"@#{self.class.key_attr}").freeze
    end

    ##
    # Fetches the value of a field.
    #
    # @param  name [Symbol]
    # @param  default_value [String, Numeric, nil]
    # @return [any]
    # @raise  [NoSuchRow] if the `SELECT` query failed to match a row and `default_value` was not given
    def get(name, default_value = NOTHING)
      table_name, key_attr, key = self.class.table_name, self.class.key_attr, self.key
      @session.client.exec_with_params("SELECT #{q(name)} FROM #{q(SCHEMA)}.#{q(table_name)} WHERE #{q(key_attr)} = $1 LIMIT 1", key) do |result|
        if result.num_tuples.zero? && default_value.equal?(NOTHING)
          raise NoSuchRow, "Failed to select row <<#{key}>> from table '#{table_name}'"
        end
        result.num_tuples.zero? ? default_value : result.getvalue(0, 0)
      end
    end

    ##
    # Updates the value of a field.
    #
    # @param  name [Symbol]
    # @param  value [String, Numeric, nil]
    # @return [void]
    # @raise  [NoSuchRow] if the `UPDATE` query failed to match a row
    def set!(name, value)
      table_name, key_attr, key = self.class.table_name, self.class.key_attr, self.key
      @session.client.exec_with_params("UPDATE #{q(SCHEMA)}.#{q(table_name)} SET #{q(name)} = $1 WHERE #{q(key_attr)} = $2", value, key) do |result|
        if result.cmd_tuples.zero?
          raise NoSuchRow, "Failed to update row <<#{key}>> in table '#{table_name}'"
        end
      end
    end

  private

    def q(s); @session.client.connection.quote_ident(s.to_s); end

    def find_class(class_name)
      case class_name
        when Class then class_name
        else self.class.const_get("Conreality::#{class_name}")
      end
    end
  end # Row
end # Conreality::Database
