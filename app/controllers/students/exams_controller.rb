class Students::ExamsController < ApplicationController
  before_action :load_course
  before_action :load_lesson
  before_action :load_exam, only: [:update, :show]

  def index
    @exams = @lesson.exams
  end

  def new
    @exam = @lesson.exams.create name: @lesson.name, number_question: 10, user_id: current_user.id
    @exam.save
    @exam.question_ids = @lesson.questions.limit(10).pluck(:id)
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "devise.registrations.updated"
      redirect_to students_course_lesson_path(@course, @lesson)
    end
  end

  def show

  end

  private

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam
    flash[:error] = t "dashboard.users.not_found"
    redirect_to students_course_lesson_path(@course, @lesson)
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
    return if @lesson
    flash[:error] = t "dashboard.users.not_found"
    redirect_to students_course_lessons_path(@course)
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = t "dashboard.users.not_found"
    redirect_to students_courses_path
  end

  def exam_params
    params.require(:exam).permit(results_attributes: [:id, :answer_id])
  end
end
