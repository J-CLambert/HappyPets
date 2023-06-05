class AddUserReferenceToPets < ActiveRecord::Migration[7.0]
  def change
    add_reference :pets, :user, foreign_key: true
  end
end
