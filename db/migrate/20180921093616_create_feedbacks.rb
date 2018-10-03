class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :message
      t.string :reply
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :feedbacks, [:user_id, :created_at]
  end
end
