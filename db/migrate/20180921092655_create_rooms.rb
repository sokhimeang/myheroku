class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :code
      t.string :name
      t.integer :volume
      t.boolean :state
      t.integer :overseer_number

      t.timestamps
    end
  end
end
