class RegisterCourse < ApplicationRecord
  # after_create :create_time_register_course
  # after_update :create_time_register_course

  belongs_to :course

  validates :date_open, presence: true

  enum status: {active: 0, not_active: 1}

  private

  def create_time_register_course
    RegisterCourseJob.set(wait_until: self.date_open)
      .perform_now(self)
  end
end
