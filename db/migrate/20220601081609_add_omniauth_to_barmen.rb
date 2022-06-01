class AddOmniauthToBarmen < ActiveRecord::Migration[6.1]
  def change
    add_column :barmen, :provider, :string
    add_column :barmen, :uid, :string
  end
end
