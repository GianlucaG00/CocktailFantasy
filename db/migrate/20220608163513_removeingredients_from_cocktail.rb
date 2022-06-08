class RemoveingredientsFromCocktail < ActiveRecord::Migration[6.1]
  def change
    remove_column :cocktails, :ingredients, :json
  end
end
