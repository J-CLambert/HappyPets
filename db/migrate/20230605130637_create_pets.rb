class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :price
      t.string :breed
      t.text :description
      t.string :title
      t.date :birthday
      t.text :vaccinated_against

      t.timestamps
    end
  end
end
