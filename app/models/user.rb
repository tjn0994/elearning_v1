class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ratyrate_rater

  after_create :create_user_setting

  has_many :posts, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :exams, dependent: :destroy
  has_many :activities
  has_many :notifications
  has_many :comments

  has_one :user_setting, dependent: :destroy

  scope :recent, ->{order created_at: :desc}
  scope :not_in_course, ->course_id do
    where "id NOT IN (select user_id from user_courses where course_id = ?)", course_id
  end

  mount_uploader :avatar, AvatarUploader

  enum gender: {female: 0, male: 1, other: 2}
  enum role: {admin: 0, teacher: 1, student: 2}

  validates :name, :number_of_phone, presence: true, on: :update
  validate :image_size

  def is_user? user
    id == user.id
  end

  def create_user_setting
    UserSetting.create user_id: self.id
  end

  private

  def image_size
    if avatar.size > Settings.max_size_image_avatar.megabytes
      errors.add :avatar, I18n.t("dashboard.users.message_error_image_avatar")
    end
  end
end
