class CreateOversees < ActiveRecord::Migration[5.2]
  def change
    create_table :oversees do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :oversees, :code
  end
end
