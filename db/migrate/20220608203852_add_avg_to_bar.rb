class AddAvgToBar < ActiveRecord::Migration[6.1]
  def change
    add_column :bars, :avg, :integer
  end
end
