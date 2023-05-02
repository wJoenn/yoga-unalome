class Session < ApplicationRecord
  validates :start_time, :end_time, :address, :capacity, presence: true
end
