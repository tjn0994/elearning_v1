class Course < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: User.name
  belongs_to :approver, class_name: User.name, optional: true

  has_many :lessons, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses

  scope :recent, ->{order created_at: :desc}
  scope :by_author, ->(owner_id){where owner_id: owner_id}

  mount_uploader :image, ImageUploader

  delegate :name, to: :user, prefix: true, allow_nil: true

  enum status: {pending: 0, approver: 1, reject: 2}

end
