class Booking < ApplicationRecord
  belongs_to :session
  belongs_to :user

  validates :cancel, inclusion: { in: [true, false] }
end
