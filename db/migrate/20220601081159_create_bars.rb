class CreateBars < ActiveRecord::Migration[6.1]
  def change
    create_table :bars do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :tel

      t.timestamps
    end
  end
end
