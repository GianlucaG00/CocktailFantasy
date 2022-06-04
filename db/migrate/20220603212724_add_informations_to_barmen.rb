class AddInformationsToBarmen < ActiveRecord::Migration[6.1]
  def change
    add_column :barmen, :name, :string
    add_column :barmen, :surname, :string
  end
end
