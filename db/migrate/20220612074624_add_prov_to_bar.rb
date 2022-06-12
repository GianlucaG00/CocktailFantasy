class AddProvToBar < ActiveRecord::Migration[6.1]
  def change
    add_column :bars, :prov, :string
  end
end
