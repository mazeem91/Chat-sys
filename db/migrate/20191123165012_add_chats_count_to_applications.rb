class AddChatsCountToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :chats_count, :integer
  end
end
