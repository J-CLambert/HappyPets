class AddOwnerToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :breeder, :boolean, default: false
  end
end
