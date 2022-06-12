class RemoveProvFromBar < ActiveRecord::Migration[6.1]
  def change
    remove_column :bars, :prov, :string
  end
end
