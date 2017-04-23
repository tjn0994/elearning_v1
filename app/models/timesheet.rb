class Timesheet < ApplicationRecord
  belongs_to :course

  scope :recent, ->{order created_at: :desc}

  enum day_name: {monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6}
end
