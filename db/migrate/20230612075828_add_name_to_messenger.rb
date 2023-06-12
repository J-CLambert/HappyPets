class AddNameToMessenger < ActiveRecord::Migration[7.0]
  def change
    add_column :messengers, :name, :string
  end
end
