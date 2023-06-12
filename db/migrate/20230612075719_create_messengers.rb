class CreateMessengers < ActiveRecord::Migration[7.0]
  def change
    create_table :messengers do |t|

      t.timestamps
    end
  end
end
