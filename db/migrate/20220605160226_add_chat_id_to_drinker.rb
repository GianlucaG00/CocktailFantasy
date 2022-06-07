class AddChatIdToDrinker < ActiveRecord::Migration[6.1]
  def change
    add_column :drinkers, :chat_id, :string
  end
end
