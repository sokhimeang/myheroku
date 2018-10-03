class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :code
      t.string :name
      t.string :email
      t.string :info
      t.string :password_digest

      t.timestamps
    end
  end
end
