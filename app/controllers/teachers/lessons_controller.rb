class Teachers::LessonsController < DashboardController
  before_action :authenticate_user!
  before_action :load_course
  before_action :authenticate_course_actice!
  before_action :load_lesson, except: [:index, :new, :create]
  load_and_authorize_resource

  def index
    @lessons = @course.lessons.page(params[:page])
      .per Settings.per_page.teachers.lesson
    @time_for_exam = TimeForExam.new
  end

  def new
    @lesson = @course.lessons.new
  end

  def create
    @lesson = @course.lessons.new lesson_params
    if @lesson.save
      create_activity_for_lesson
      flash[:success] = "Tạo bài học thành công"
      redirect_to teachers_course_lessons_path
    else
      render :new
    end
  end

  def show
  end

  def edit; end

  def update
    if @lesson.update_attributes lesson_params
      create_activity_for_lesson
      flash[:success] = "Cập nhật bài học thành công"
      redirect_to teachers_course_lessons_path
    else
      render :edit
    end
  end

  def destroy
    if @lesson.destroy
      create_activity_for_lesson
      flash[:success] = "Xóa bài học thành công"
    else
      flash[:warning] = "Xóa bài học không thành công"
    end
    redirect_to teachers_course_lessons_path
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :description, :content)
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    return if @lesson
    flash[:error] = "Bài học không tìm thấy"
    redirect_to teachers_course_lessons_path
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = "Khóa học không tìm thấy"
    redirect_to teachers_courses_path
  end

  def create_activity_for_lesson
    create_activity Lesson.name, @lesson, @_action_name
  end

  def authenticate_course_actice!
    return if @course.active?
    flash[:error] = "Khóa học chưa được cho phép hoạt động"
    redirect_to teachers_courses_path
  end
end
