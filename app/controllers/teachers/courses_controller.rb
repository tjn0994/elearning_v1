class Teachers::CoursesController < DashboardController
  before_action :load_course, only: [:edit, :update, :destroy]
  before_action :load_category

  def index
    @courses = Course.by_author(current_user.id).recent.page(params[:page])
      .per Settings.per_page.teachers.course
  end

  def new
    @course = Course.new
    @timesheet = @course.timesheets.build
    @types = @categories.first.types
  end

  def create
    @course = Course.new course_params
    if @course.save
      create_activity_for_course
      flash[:success] = t "devise.registrations.signed_up"
      redirect_to teachers_courses_path
    else
      @types = @course.type.category.types
      @category_ = @course.type.category
      render :new
    end
  end

  def show
    @course = Course.find_by id: params[:id]
    respond_to do |format|
      format.html{render partial: "details_information", local: {course: @course}}
    end
  end

  def edit
    @types = @course.type.category.types
    @category_ = @course.type.category
  end

  def update
    if @course.update_attributes course_params
      create_activity_for_course
      flash[:success] = t "devise.registrations.updated"
      redirect_to teachers_courses_path
    else
      @types = @course.type.category.types
      @category_ = @course.type.category
      render :edit
    end
  end

  def destroy
    if @course.destroy
      create_activity_for_course
      flash[:success] = t "devise.registrations.destroyed"
    else
      flash[:warning] = t "delete_not_success"
    end
    redirect_to teachers_courses_path
  end

  private

  def course_params
    params.require(:course).permit(:type_id, :name, :description, :image,
      :date_from, :date_to, timesheets_attributes: [:id, :time_from, :time_to, :day_name, :_destroy])
      .merge! owner_id: current_user.id
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_courses_path
  end

  def load_category
    @categories = Category.all
  end

  def create_activity_for_course
    create_activity Course.name, @course, @_action_name
  end
end
