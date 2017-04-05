class Course < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: User.name
  belongs_to :approver, class_name: User.name

  has_many :lessons, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
end
