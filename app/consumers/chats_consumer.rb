class ChatsConsumer < ApplicationConsumer
    def consume
        chats = []
        params_batch.each do |chat|
            puts chat['payload']
            chats << Chat.new(chat['payload'])
        end
        Chat.bulk_import chats
    end
end