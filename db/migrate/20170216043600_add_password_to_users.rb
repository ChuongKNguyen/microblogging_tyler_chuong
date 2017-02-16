class AddPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :password, :string, default: "12345"
  end
end
