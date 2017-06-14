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

    # @!group Sessions

    # TODO

    # @!endgroup

    # @!group Theaters

    ##
    # Returns the theater identified by the given UUID.
    #
    # @param  uuid [String] the theater's UUID
    # @return [Theater] the theater
    def find_theater(uuid)
      Theater.new(uuid, self)
    end

    ##
    # @todo
    def each_theater(&block)
      # TODO
    end

    # @!endgroup

    # @!group Objects

    ##
    # Returns the object identified by the given UUID.
    #
    # @param  uuid [String] the object's UUID
    # @return [Object] the object
    def find_object(uuid)
      Object.new(uuid, self)
    end

    ##
    # @todo
    def each_object(&block)
      # TODO
    end

    # @!endgroup

    # @!group Events

    ##
    # @param  predicate [String] a predicate string
    # @param  subject   [Object, UUID] the source object
    # @param  object    [Object, UUID, nil] the target object, if any
    # @return [Event]   the sent event
    def send_event(predicate, subject, object = nil)
      predicate = predicate.to_s
      subject   = (subject.respond_to?(:uuid) ? subject.uuid : subject).to_s
      object    = object ? (object.respond_to?(:uuid) ? object.uuid : object).to_s : nil

      result = self.call_proc_with_result('public.event_send($1, $2, $3)', subject, predicate, object)
      result ? Event.new(result.to_i, self) : nil
    end

    # @!endgroup

    # @!group Messaging

    ##
    # @param  sender    [Object, UUID] the sending asset or player
    # @param  text      [String] the message contents as text
    # @return [Message] the sent message
    # @todo   Support for audio messages.
    def send_message(sender, text)
      sender = (sender.respond_to?(:uuid) ? sender.uuid : sender).to_s
      text = text.to_s

      result = self.call_proc_with_result('public.message_send($1, $2)', sender, text)
      result ? Message.new(result.to_i, self) : nil
    end

    # @!endgroup

    # @!group Low-level

    ##
    # @param  signature [String]
    # @param  arguments [Array]
    # @return [::Object]
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
