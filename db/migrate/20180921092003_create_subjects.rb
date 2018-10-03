class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :code, unique: true
      t.string :name
      t.integer :times_exam

      t.timestamps
    end
  end
end
