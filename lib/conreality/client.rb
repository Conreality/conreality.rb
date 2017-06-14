require 'pg'
require 'uuid'

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

      result = self.call_proc_with_result('public.event_send($1, $2, $3)', subject, predicate, object)
      result ? result.to_i : nil
    end

    # @!endgroup

    # @!group Messaging

    ##
    # @param  sender    [UUID]   the sending asset or player
    # @param  text      [String] the message contents as text
    # @return [Integer] the message ID
    # @todo   Support for audio messages.
    def send_message(sender, text)
      sender, text = sender.to_s, text.to_s

      result = self.call_proc_with_result('public.message_send($1, $2)', sender, text)
      result ? result.to_i : nil
    end

    # @!endgroup

    # @!group Low-level

    ##
    # @param  signature [String]
    # @param  arguments [Array]
    # @return [Object]
    def call_proc_with_result(signature, *arguments)
      self.call_proc(signature, *arguments) do |results|
        results.getvalue(0, 0)
      end
    end

    ##
    # @param  signature [String]
    # @param  arguments [Array]
    # @return [PG::Result]
    def call_proc(signature, *arguments, &block)
      @conn.exec_params("SELECT #{signature}", arguments, &block)
    end

    # @!endgroup
  end # Client
end # Conreality
