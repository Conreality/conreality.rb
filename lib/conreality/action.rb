# This is free and unencumbered software released into the public domain.

module Conreality
  ##
  # A transaction-scoped action.
  class Action
    ##
    # The client session this actions belongs to.
    #
    # @return [Session]
    attr_reader :session

    ##
    # @param session [Session]
    def initialize(session)
      @session = session
    end

    ##
    # Returns a developer-friendly representation of this action.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x>", self.class.name, self.__id__)
    end

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

      result = @session.client.call_proc_with_result(:event_send, args: [predicate, subject, object])
      result ? Conreality::Event.new(@session, result.to_i) : nil
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

      result = @session.client.call_proc_with_result(:message_send, args: [sender, text])
      result ? Conreality::Message.new(@session, result.to_i) : nil
    end

    # @!endgroup
  end # Action
end # Conreality
