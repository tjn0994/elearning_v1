class Teachers::TimeForExamsController < DashboardController
  before_action :load_course
  before_action :load_lesson
  before_action :load_time_for_exam, only: [:edit, :update]

  def new
    respond_to do |format|
      format.js{}
    end
  end

  def create
    if @lesson.time_for_exam.blank?
      @time_for_exam = TimeForExam.new time_for_exam_params.merge!(lesson_id: @lesson.id)
      if @time_for_exam.save
        respond_to do |format|
          format.js{}
        end
      else
        render :new
      end
    end
  end

  def edit
    respond_to do |format|
      format.js{}
    end
  end

  def update
    if @time_for_exam.update_attributes time_for_exam_params
      respond_to do |format|
        format.js{}
      end
    else
      render :edit
    end
  end

  private

  def time_for_exam_params
    params.require(:time_for_exam).permit(:time, :number_question)
  end

  def create_activity_for_time_exam
    create_activity TimeForExam.name, @time_for_exam, @_action_name
  end

  def load_time_for_exam
    @time_for_exam = TimeForExam.find_by id: params[:id]
    return if @time_for_exam
    flash[:error] = "Không tìm thấy thời gian đăng ký khóa học"
    redirect_to teachers_course_lessons_path(@course)
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
    return if @lesson
    flash[:error] = "Không tìm thấy bài học"
    redirect_to teachers_course_lessons_path(@course)
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to teachers_courses_path
  end
end
