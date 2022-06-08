class AddRolesToDrinkers < ActiveRecord::Migration[6.1]
  def change
    add_column :drinkers, :roles_mask, :integer
  end
end
