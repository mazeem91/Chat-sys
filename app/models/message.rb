class Message < ApplicationRecord
  belongs_to :chat
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  settings do
    mappings dynamic: false do
      indexes :body, type: :text, analyzer: :english
    end
  end
end
