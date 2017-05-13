class RegisterCourse < ApplicationRecord
  after_create :create_time_register_course
  after_update :create_time_register_course

  belongs_to :course

  validates :date_open, presence: true

  enum status: {active: 0, not_active: 1}

  def open_time_register_course
    self.update status: :active
  end

  def create_time_register_course
    # delay(run_at: 1.minutes.from_now).open_time_register_course
  end
end
