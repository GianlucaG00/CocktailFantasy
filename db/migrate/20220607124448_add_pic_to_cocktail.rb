class AddPicToCocktail < ActiveRecord::Migration[6.1]
  def change
    add_column :cocktails, :pic, :string
  end
end
