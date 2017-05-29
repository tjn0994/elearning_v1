class RegisterCourse < ApplicationRecord

  belongs_to :course

  validates :date_open, presence: true
  validates :date_close, presence: true
  validate :invalid_valid, if: ->{date_open.present? && date_close.present?}

  enum status: {active: 0, not_active: 1}

  # def create_time_register_course
  #   delay(run_at: 1.minutes.from_now).open_time_register_course
  # end

  def invalid_valid
    if date_open >= date_close
      errors.add :base, "Ngày kết thúc phải lớn hơn ngày bắt đầu"
    end
  end
end
