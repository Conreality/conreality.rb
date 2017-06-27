module Conreality
  module Database
    SCHEMA  = :conreality

    NOTHING = Object.new.freeze
  end # Database
end # Conreality

require 'conreality/database/error'
require 'conreality/database/row'
