class AddNameToDrinker < ActiveRecord::Migration[6.1]
  def change
    add_column :drinkers, :name, :string
  end
end
