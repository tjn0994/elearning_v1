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
    can :create, Post
    cannot [:read, :update], User
    can [:read, :update], User, id: user.id
    can :read, UserCourse, user_id: user.id
    can :read, Lesson, user.courses.include?(:course_id)
    can [:read, :create, :update], Exam
  end

  def admin_permission user
    can :manage, :all
  end

  def teacher_permission user
    # cannot [:read, :update], User
    can [:read, :update], User, id: user.id
    can [:read, :create, :update], Course, owner_id: user.id
    can [:read, :create, :update], Lesson
    can [:read, :create, :update], Question
    can [:read, :create, :update], TimeForExam
    can [:read, :create, :update], RegisterCourse
  end
end

