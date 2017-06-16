module Conreality
  module Database
    SCHEMA  = :public

    NOTHING = Object.new.freeze
  end # Database
end # Conreality

require 'conreality/database/error'
require 'conreality/database/row'
require 'conreality/database/transaction'
