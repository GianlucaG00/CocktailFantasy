class AddBarmanToBar < ActiveRecord::Migration[6.1]
  def change
    add_reference :bars, :barman, null: false, foreign_key: true
  end
end
