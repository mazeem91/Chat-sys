class ChatResponder < ApplicationResponder
    topic "1jkft6j2-chats"
  
    def respond(event_payload)
      respond_to "1jkft6j2-chats", event_payload
    end
  end
  