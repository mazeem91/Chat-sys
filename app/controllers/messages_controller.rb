class MessagesController < ApplicationController
    before_action :set_chat

    def index
      messages = @chat.messages
      json_response(messages)
    end

    def create

      @message = Message.new(chat_id: @chat.id)
      @message.created_at = Time.now
      @message.updated_at = Time.now
      @message.number = get_message_next_number(@chat.id)
      @message.body = message_params[:body]
      MessageResponder.call(@message)
      json_response(@message, :created)
    end

    private
    def message_params
      params.permit(:token, :number, :body)
    end
  
    def set_chat
      application = Application.find_by(token: message_params[:token])
      @chat = application.chats.find_by(number: message_params[:number])
    end

    def get_message_next_number(chat_id)
      message_number = REDIS_CLIENT.get("message_number.#{chat_id}").to_i
      if message_number == nil
        db_message_number = Chat.where(chat_id: chat_id).last.number || 0
        message_number = redis_set_message_number(chat_id, db_message_number)
      end
      redis_set_message_number(chat_id, message_number + 1)
    end

    def redis_set_message_number(chat_id, value)
      REDIS_CLIENT.watch "message_number.#{chat_id}"
      result = REDIS_CLIENT.multi do
        REDIS_CLIENT.set "message_number.#{chat_id}", value
        REDIS_CLIENT.get "message_number.#{chat_id}"
      end
      result.last.to_i
    end
end
