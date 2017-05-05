class Question < ApplicationRecord
  belongs_to :lesson

  has_many :answers, dependent: :destroy
  has_many :results
  has_many :exams, through: :results

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:name].blank? }

  scope :recent, ->{order created_at: :desc}

  validates :name, presence: true
  validates :answers, presence: true
  validate :have_answer_true, if: ->{self.answers.present?}

  private

  def have_answer_true
    answer = self.answers.find{|k| k.is_correct.present?}
    errors.add :base, "Phải có ít nhất 1 đáp án đúng" if answer.blank?
  end
end
