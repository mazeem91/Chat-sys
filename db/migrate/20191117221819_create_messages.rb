class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number
      t.references :chat, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
