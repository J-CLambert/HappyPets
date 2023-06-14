class RemoveTitleFromPet < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets, :title, :string
  end
end
