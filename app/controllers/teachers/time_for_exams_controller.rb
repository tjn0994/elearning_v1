class Teachers::TimeForExamsController < DashboardController
  before_action :load_course
  before_action :load_lesson
  before_action :load_time_for_exam, except: [:index, :new, :create]

  def index
    @time_for_exam = TimeForExam.new
  end

  def create
    @time_for_exam = TimeForExam.new time_for_exam_params
    @time_for_exam.update lesson_id: @lesson.id
    if @time_for_exam.save
      create_activity_for_time_exam
      flash[:success] = t "devise.registrations.signed_up"
     redirect_to teachers_course_lessons_path(@course)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @time_for_exam.update_attributes time_for_exam_params
      create_activity_for_time_exam
      flash[:success] = t "devise.registrations.updated"
     redirect_to teachers_course_lessons_path(@course)
    else
      render :edit
    end
  end

  private

  def time_for_exam_params
    params.require(:time_for_exam).permit(:time, :number_question)
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_courses_path
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
    return if @lesson
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_course_lessons_path(@course)
  end

  def load_time_for_exam
    @time_for_exam = TimeForExam.find_by id: params[:id]
    return if @question
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_course_lessons_path(@course)
  end

  def create_activity_for_time_exam
    create_activity TimeForExam.name, @time_for_exam, @_action_name
  end
end
