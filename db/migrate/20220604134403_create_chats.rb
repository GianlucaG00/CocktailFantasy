class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :chat_id
      t.string :option
      t.references :bar

      t.timestamps
    end
  end
end
