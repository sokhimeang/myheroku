class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :code_subject
      t.string :name_subject
      t.integer :times_exam
      t.string :room_code
      t.string :room_name
      t.string :day
      t.integer :session
      t.integer :group

      t.timestamps
    end
  end
end
