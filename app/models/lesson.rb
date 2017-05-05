class Lesson < ApplicationRecord
  belongs_to :course

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_one :time_for_exam, dependent: :destroy

  scope :recent, ->{order created_at: :desc}

  validates :name, presence: true
  validates :name, length: {maximum: 255, minimum: 2}, if: ->{name.present?}
  validates :description, length: {maximum: 255}, if: ->{description.present?}
  validates :content, presence: true
end
