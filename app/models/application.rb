class Application < ApplicationRecord
    validates :name, presence: true
    has_many :chats
    after_validation :set_token, on: [:create]

    private
        def set_token
            self.token = SecureRandom.uuid
        end
end
