class AddDescriptionPicToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :description, :string, default: "Tell us about yourself"
  	add_column :users, :avatar, :string, default: "Your avatar"
  end
end
