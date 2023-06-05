class AddSpeciesReferencesToPets < ActiveRecord::Migration[7.0]
  def change
    add_reference :pets, :species, null: false, foreign_key: true
  end
end
