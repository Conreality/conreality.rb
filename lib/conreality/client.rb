require 'pg'

module Conreality
  ##
  # Client for accessing a Conreality master server.
  class Client
    # @return [PG::Connection]
    attr_accessor :conn

    ##
    # @param  options [Hash]
    # @option options [String] :dbname
    def initialize(options = {})
      @conn = PG.connect(options)
    end

    # @!group Events

    ##
    # @param  predicate [String] a predicate string
    # @param  subject   [UUID]   the subject entity
    # @param  object    [UUID]   the object entity
    # @return [Integer] the event ID
    def send_event(predicate, subject, object = nil)
      predicate = predicate.to_s
      subject   = subject.to_s
      object    = object ? object.to_s : nil
      @conn.exec_params("SELECT public.event_send($1, $2, $3)", [subject, predicate, object]) do |results|
        result = results.getvalue(0, 0)
        result ? result.to_i : nil
      end
    end

    # @!endgroup
  end # Client
end # Conreality
