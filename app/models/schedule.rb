class Schedule < ApplicationRecord
  has_many :invitations, foreign_key: :schedule_id, dependent: :destroy
  has_many :users, through: :invitations, source: :user

  def add_user user
    users << user
  end

  def remove_user user
    users.delete user
  end

  def was_exist? user
    users.include? user
  end

end
