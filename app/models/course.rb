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
  scope :by_active, ->{where status: :active}
  scope :by_register_course_active, ->(date)do
    joins(:register_course)
      .where("register_courses.status = 0 and register_courses.date_open <= Date(?) and
        register_courses.date_close >= Date(?)", date, date)
  end
  # scope :by_user_course_active, -> do
  #   joins(:user_course)
  #     .where("user_courses.status = 1")
  # end

  mount_uploader :image, ImageUploader

  enum status: {pending: 0, active: 1, block: 2}

  validates :name, presence: true
  validates :name, length: {maximum: 255, minimum: 2}, if: ->{name.present?}
  validates :description, length: {maximum: 255}, if: ->{description.present?}
  validates :date_from, presence: true
  validates :date_to, presence: true
  validates :timesheets, presence: true
  validate :date_register_blank?
  validate :valid_date_for_course, if: :date_from_present? && :date_to_present?
  validate :timesheets_course
  validate :timesheets_of_course_exist, if: ->{errors[:time_register].blank? && errors[:time].blank?}

  delegate :name, to: :owner, prefix: true, allow_nil: true
  delegate :name, to: :approver, prefix: true, allow_nil: true
  delegate :name, :id, to: :room, prefix: true, allow_nil: true

  private

  def date_register_blank?
    if date_from.blank? || date_to.blank?
      errors.add :date_register_blank, "Ngày không được để trống"
    end
  end

  def valid_date_for_course
    if date_to <= date_from
      return errors.add :errors, "Ngày kết thúc phải lớn hơn ngày bắt đầu"
    else
      if date_to < date_from + 1.month
        return errors.add :errors, "Ngày đăng ký phải ít nhất 1 tháng"
      end
    end
  end

  def date_from_present?
    date_from.present?
  end

  def date_to_present?
    date_to.present?
  end

  def timesheets_course
    arr_timesheet = []
    timesheets.each_with_index do |timesheet, index|
      error = ""
      if timesheet.time_to <= timesheet.time_from
        error = "Thời gian kết thúc phải lớn hơn thời gian bắt đầu"
      end
      if arr_timesheet.present?
        arr_timesheet.each do |k|
          if k[:day_name] == timesheet.day_name
            unless timesheet.time_from >= k[:time_to] || timesheet.time_to <= k[:time_from]
              return errors.add :time_register, ["Thời gian bị trùng, bạn nên sắp xếp lại thời gian", index]
            end
          end
        end
      end
      arr_timesheet << {"day_name": timesheet.day_name, "time_from": timesheet.time_from, "time_to": timesheet.time_to, "error": error}
    end
    arr_errors = []
    arr_timesheet.select{|k| arr_errors << k[:error]}
    if arr_errors.present?
      count = arr_errors.find{|k| k.present? }
      errors.add :time, arr_errors if count.present?
    end
  end

  def timesheets_of_course_exist
    courses = Course.by_author(self.owner_id).by_active
    courses.each do |course|
      if id.present?
        unless course.id == id
          course.timesheets.each do |k|
            timesheets.each_with_index do |timesheet, index|
              if k.day_name == timesheet.day_name
                unless timesheet.time_from.strftime("%H:%M") >= k.time_to.strftime("%H:%M") ||
                  timesheet.time_to.strftime("%H:%M") <= k.time_from.strftime("%H:%M")
                  return errors.add :time_register, ["Thời gian bị trùng ở khóa học #{course.name}, bạn nên sắp xếp lại thời gian", index]
                end
              end
            end
          end
        end
      else
        course.timesheets.each do |k|
          timesheets.each_with_index do |timesheet, index|
            if k.day_name == timesheet.day_name
              unless timesheet.time_from.strftime("%H:%M") >= k.time_to.strftime("%H:%M") ||
                timesheet.time_to.strftime("%H:%M") <= k.time_from.strftime("%H:%M")
                return errors.add :time_register, ["Thời gian bị trùng ở khóa học #{course.name}, bạn nên sắp xếp lại thời gian", index]
              end
            end
          end
        end
      end
    end
  end
end
