class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :recent, ->{order created_at: :desc}

  mount_uploader :avatar, AvatarUploader

  enum gender: {female: 0, male: 1, other: 2}
  enum role: {admin: 0, teacher: 1, student: 2}

  validate :image_size

  private

  def image_size
    if avatar.size > Settings.max_size_image_avatar.megabytes
      errors.add :avatar, I18n.t("dashboard.users.message_error_image_avatar")
    end
  end
end
