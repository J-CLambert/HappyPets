class RemoveSpeciesFromPets < ActiveRecord::Migration[7.0]
  def change
    remove_reference :pets, :species, null: false, foreign_key: true
  end
end
