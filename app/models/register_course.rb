class RegisterCourse < ApplicationRecord

  belongs_to :course

  validates :date_open, presence: true
  validates :date_close, presence: true

  enum status: {active: 0, not_active: 1}

  # def create_time_register_course
  #   delay(run_at: 1.minutes.from_now).open_time_register_course
  # end
end
