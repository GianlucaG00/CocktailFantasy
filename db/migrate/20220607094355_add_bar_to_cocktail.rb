class AddBarToCocktail < ActiveRecord::Migration[6.1]
  def change
    add_reference :cocktails, :bar, null: false, foreign_key: true
  end
end
