class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :canceled, inclusion: { in: [true, false] }

  def canceled?
    canceled
  end
end