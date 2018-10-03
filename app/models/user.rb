class User < ApplicationRecord
  has_one :oversee
  has_many :feedbacks

  has_many :class_students, foreign_key: :user_id, dependent: :destroy
  has_many :subjects, through: :class_students, source: :subject

  has_many :invitations, foreign_key: :user_id, dependent: :destroy
  has_many :schedules, through: :invitations, source: :schedule

  scope :order_id_desc, ->{order id: :desc}

  def add_subject subject_exam
    subjects << subject_exam
  end

  def remove_subject subject_exam
    subjects.delete subject_exam
  end
end
