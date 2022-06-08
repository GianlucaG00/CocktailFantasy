class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :option
      t.references :bar, null: false, foreign_key: true
      t.references :drinker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
