class Course < ApplicationRecord

  belongs_to :type
  belongs_to :owner, class_name: User.name
  belongs_to :approver, class_name: User.name, optional: true

  has_many :lessons, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :timesheets, dependent: :destroy

  has_one :register_course, dependent: :destroy
  has_one :room, dependent: :destroy

  accepts_nested_attributes_for :timesheets, allow_destroy: true,
    reject_if: :all_blank

  scope :recent, ->{order created_at: :desc}
  scope :by_author, ->(owner_id){where owner_id: owner_id}

  mount_uploader :image, ImageUploader

  enum status: {pending: 0, active: 1, block: 2}

  validates :name, presence: true, length: {maximum: 255, minimum: 2}
  validates :date_from, presence: true
  validates :date_to, presence: true
  validate :valid_date_for_course, if: :date_from_present? && :date_to_present?
   #if: ->{date_from.present?}

  delegate :name, to: :owner, prefix: true, allow_nil: true
  delegate :name, to: :approver, prefix: true, allow_nil: true

  private

  def valid_date_for_course
    if date_to <= date_from
      return errors.add :errors, "date form should less than date to"
    else
      if date_to < date_from + 1.month
        return errors.add :errors, "date form should less than 1 month"
      end
    end
  end

  def date_from_present?
    date_from.present?
  end

  def date_to_present?
    date_to.present?
  end
end
