class CreateAds < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|
      t.string :name
      t.string :address
      t.string :tel
      t.text :description

      t.timestamps
    end
  end
end
