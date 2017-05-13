class TimeForExam < ApplicationRecord
  belongs_to :lesson

  validates :number_question, numericality: {greater_than: 0, only_integer: true}
  validate :valid_number_question, if: ->{self.number_question.present?}

  private

  def valid_number_question
    if lesson.questions.count == 0
      errors.add :base, "Vui lòng tạo dữ liệu cho cậu hỏi, hiện tại chưa có câu hỏi nào !"
    elsif number_question > lesson.questions.count
      errors.add :base, "Số cầu hỏi không hợp lệ, tối đa chỉ #{lesson.questions.count} câu"
    end
  end
end
