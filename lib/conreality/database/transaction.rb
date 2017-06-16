module Conreality::Database
  ##
  # Encapsulates a database transaction.
  class Transaction
    ##
    # @param client [Client]
    def initialize(client)
      @client = client
    end
  end # Transaction
end # Conreality::Database
