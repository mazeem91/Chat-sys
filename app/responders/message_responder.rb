class MessageResponder < ApplicationResponder
    topic "1jkft6j2-messages"
  
    def respond(event_payload)
      respond_to "1jkft6j2-messages", event_payload
    end
  end
  