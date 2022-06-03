class CreateCocktails < ActiveRecord::Migration[6.1]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.text :preparation
      t.json :ingredients
      t.integer :price

      t.timestamps
    end
  end
end
