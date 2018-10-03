class CreateClassStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :class_students do |t|
      t.references :user, index: true
      t.references :subject, index: true

      t.timestamps
    end
  end
end
