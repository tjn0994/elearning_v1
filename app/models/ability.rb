class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case
    when user.admin?
      admin_permission user
    when user.teacher?
      teacher_permission user
    when user.student?
      student_permission user
    end
  end

  def student_permission user
    can :read, Category
    cannot :manage, TimeForExam
    cannot :manage, RegisterCourse
    can :create, Post
    cannot [:read, :update], User
    can [:read, :update], User, id: user.id
    can :read, UserCourse, user_id: user.id
    can :read, Lesson do |lesson|
      user.course_ids.include?(lesson.course_id) && user.courses.present?
    end
    can [:read, :create, :update], Exam
  end

  def admin_permission user
    can :manage, :all
  end

  def teacher_permission user
    can :read, Category
    cannot [:read, :update], User
    can [:read, :update], User, id: user.id
    can :manage, Course, owner_id: user.id
    can :manage, Lesson
    can :manage, Question
    can :manage, TimeForExam
    can :manage, RegisterCourse
    can :manage, UserCourse, user.courses.include?(:course_id)
  end
end

