class AddPicToBars < ActiveRecord::Migration[6.1]
  def change
    add_column :bars, :pic, :string
  end
end
