module Conreality
  module Database
    NOTHING = Object.new.freeze
  end # Database
end # Conreality

require 'conreality/database/error'
require 'conreality/database/row'
require 'conreality/database/transaction'
