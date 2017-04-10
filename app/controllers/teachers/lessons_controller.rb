class Teachers::LessonsController < DashboardController
  before_action :load_course
  before_action :load_lesson, except: [:index, :new, :create]

  def index
    @lessons = @course.lessons.recent.page(params[:page])
      .per Settings.per_page.teachers.lesson
  end

  def new
    @lesson = @course.lessons.new
  end

  def create
    @lesson = @course.lessons.new lesson_params
    if @lesson.save
      flash[:success] = t "devise.registrations.signed_up"
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
      flash[:success] = t "devise.registrations.updated"
      redirect_to teachers_course_lessons_path
    else
      render :edit
    end
  end

  def destroy
    if @lesson.destroy
      flash[:success] = t "devise.registrations.destroyed"
    else
      flash[:warning] = t "delete_not_success"
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
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_course_lessons_path
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_courses_path
  end
end
