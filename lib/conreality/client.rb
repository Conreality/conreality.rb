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
    # @param  subject   [UUID]   the source object
    # @param  object    [UUID]   the target object, if any
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

    # @!group Messages

    ##
    # @param  sender    [UUID]   the sending asset or player
    # @param  text      [String] the message contents as text
    # @return [Integer] the message ID
    # @todo   Support for audio messages.
    def send_message(sender, text)
      sender, text = sender.to_s, text.to_s
      @conn.exec_params("SELECT public.message_send($1, $2)", [sender, text]) do |results|
        result = results.getvalue(0, 0)
        result ? result.to_i : nil
      end
    end

    # @!endgroup
  end # Client
end # Conreality
