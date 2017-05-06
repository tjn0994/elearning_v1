class Students::ExamsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_course
  before_action :load_lesson
  before_action :load_exam, only: [:update, :show]

  def index
    @exams = @lesson.exams.of_member(current_user.id).page(params[:page])
      .per Settings.per_page.students.exam
    if @exams.blank?
      flash[:error] = "Bạn chưa làm bài kiểm tra"
      redirect_to students_course_lesson_path(@course, @lesson)
    end
  end

  def new
    if @lesson.time_for_exam.present?
      @exam = @lesson.exams.create name: @lesson.name, user_id: current_user.id
      @exam.save
      @exam.question_ids = @lesson.questions.limit( @lesson.time_for_exam.number_question).pluck(:id)
    else
      flash[:error] = "Chưa có đề kiểm tra"
      redirect_to students_course_lesson_path(@course, @lesson)
    end
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = "Bạn vừa làm xong bài kiểm tra"
      redirect_to students_course_lesson_path(@course, @lesson)
    end
  end

  def show
  end

  private

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam
    flash[:error] = "Không tìm thấy bài kiểm tra"
    redirect_to students_course_lesson_path(@course, @lesson)
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
    return if @lesson
    flash[:error] = "Không tìm thấy bài học"
    redirect_to students_course_lessons_path(@course)
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to students_courses_path
  end

  def exam_params
    params.require(:exam).permit(results_attributes: [:id, :answer_id])
  end
end
