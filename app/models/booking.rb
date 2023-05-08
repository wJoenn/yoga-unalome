class Booking < ApplicationRecord
  belongs_to :session
  belongs_to :user

  validates :canceled, inclusion: { in: [true, false] }

  def canceled?
    cenceled
  end
end
