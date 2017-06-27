module Conreality
  ##
  # A transaction-scoped action.
  class Action
    ##
    # @param client [Client]
    def initialize(client)
      @client = client
    end

    ##
    # Returns a developer-friendly representation of this action.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x>", self.class.name, self.__id__)
    end

    # @!group Theaters

    ##
    # Returns the theater identified by the given UUID.
    #
    # @param  uuid [String] the theater's UUID
    # @return [Theater] the theater
    def find_theater(uuid)
      Conreality::Theater.new(@client, uuid)
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
      Conreality::Object.new(@client, uuid)
    end

    ##
    # @todo
    def each_object(&block)
      # TODO
    end

    # @!endgroup

    # @!group Events

    ##
    # @todo
    # @return [Event] the event
    def find_event(id)
      # TODO
    end

    ##
    # @param  predicate [String] a predicate string
    # @param  subject   [Object, UUID] the source object
    # @param  object    [Object, UUID, nil] the target object, if any
    # @return [Event]   the sent event
    def send_event(predicate, subject, object = nil)
      predicate = predicate.to_s
      subject   = (subject.respond_to?(:uuid) ? subject.uuid : subject).to_s
      object    = object ? (object.respond_to?(:uuid) ? object.uuid : object).to_s : nil

      result = @client.call_proc_with_result(:event_send, args: [subject, predicate, object])
      result ? Conreality::Event.new(@client, result.to_i) : nil
    end

    # @!endgroup

    # @!group Messaging

    ##
    # @todo
    # @return [Message] the message
    def find_message(id)
      # TODO
    end

    ##
    # @param  sender    [Object, UUID] the sending asset or player
    # @param  text      [String] the message contents as text
    # @return [Message] the sent message
    # @todo   Support for audio messages.
    def send_message(sender, text)
      sender = (sender.respond_to?(:uuid) ? sender.uuid : sender).to_s
      text = text.to_s

      result = @client.call_proc_with_result(:message_send, args: [sender, text])
      result ? Conreality::Message.new(@client, result.to_i) : nil
    end

    # @!endgroup
  end # Action
end # Conreality
