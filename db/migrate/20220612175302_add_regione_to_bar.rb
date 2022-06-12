class AddRegioneToBar < ActiveRecord::Migration[6.1]
  def change
    add_column :bars, :regione, :string
  end
end
