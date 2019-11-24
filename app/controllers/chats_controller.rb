class ChatsController < ApplicationController
    before_action :set_application

    def index
      json_response(@application.chats)
    end

    def create
      @chat = Chat.new(application_id: @application.id)
      @chat.created_at = Time.now
      @chat.updated_at = Time.now
      @chat.number = get_chat_next_number(@application.id)
      ChatResponder.call(@chat)
      json_response(@chat, :created)
    end

    private
    def chat_params
      params.permit(:token)
    end
  
    def set_application
      @application = Application.find_by(chat_params)
      json_response({}, :not_found) if !@application
    end

    def get_chat_next_number(application_id)
      chat_number = REDIS_CLIENT.get("chat_number.#{application_id}").to_i
      if chat_number == nil
        db_chat_number = Chat.where(application_id: application_id).last.number || 0
        chat_number = redis_set_chat_number(application_id, db_chat_number)
      end
      redis_set_chat_number(application_id, chat_number + 1)
    end

    def redis_set_chat_number(application_id, value)
      REDIS_CLIENT.watch "chat_number.#{application_id}"
      result = REDIS_CLIENT.multi do
        REDIS_CLIENT.set "chat_number.#{application_id}", value
        REDIS_CLIENT.get "chat_number.#{application_id}"
      end
      result.last.to_i
    end
end
