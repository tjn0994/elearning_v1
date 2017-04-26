class RegisterCourse < ApplicationRecord
  belongs_to :course

  validates :open_close, presence: true
end
