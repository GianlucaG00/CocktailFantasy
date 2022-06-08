class AddIngredientsToCocktails < ActiveRecord::Migration[6.1]
  def change
    add_column :cocktails, :ingredients, :string
  end
end
