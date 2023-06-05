class DropSpecies < ActiveRecord::Migration[7.0]
  def change
    drop_table :species
  end
end
