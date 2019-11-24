class MessagesConsumer < ApplicationConsumer
    def consume
        messages = []
        params_batch.each do |message|
            puts message['payload']
            messages << Message.new(message['payload'])
        end
        Message.import messages
    end
end