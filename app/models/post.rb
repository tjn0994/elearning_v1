class Post < ApplicationRecord
  belongs_to :type
  belongs_to :user

  has_many :comments, dependent: :destroy

  ratyrate_rateable 'visual_effects', 'original_score', 'director', 'custome_design'

  scope :recent, ->{order created_at: :desc}
  scope :of_member, ->(user_id){where user_id: user_id}

  validates :title, presence: true
  validates :title, length: {maximum: 255, minimum: 2}, if: ->{title.present?}
  validates :content, presence: true

  delegate :avatar, :name, :email, :id, to: :user, prefix: true, allow_nil: true
end
