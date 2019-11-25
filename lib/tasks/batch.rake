namespace :batch do
  desc "TODO"
  task sync_counts: :environment do
    applications_sql = "UPDATE applications SET chats_count = (SELECT COUNT(*) FROM chats WHERE application_id=applications.id)"
    chats_sql = "UPDATE chats SET messages_count = (SELECT COUNT(*) FROM messages WHERE chat_id=chats.id)"
    ActiveRecord::Base.connection.execute(applications_sql)
    ActiveRecord::Base.connection.execute(chats_sql)
    # Message.import(force: true)
  end

end
