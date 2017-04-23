class Post < ApplicationRecord
  belongs_to :type
  belongs_to :user

  has_many :comments, dependent: :destroy

  ratyrate_rateable 'visual_effects', 'original_score', 'director', 'custome_design'

  scope :recent, ->{order created_at: :desc}

  validates :title, presence: true, length: {maximum: 255, minimum: 2}
  validates :content, presence: true
end
