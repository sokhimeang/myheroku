class Room < ApplicationRecord
  has_many :schedules
  validates :code, presence: true
end
