class Teachers::QuestionsController < DashboardController
  before_action :authenticate_user!
  before_action :load_course
  before_action :load_lesson
  before_action :load_question, except: [:index, :new, :create]
  load_and_authorize_resource

  def index
    init_variable
    @question = @lesson.questions.new
    @answer = @question.answers.build
  end

  def create
    @question = @lesson.questions.new question_params
    if @question.save
      create_activity_for_question
      flash[:success] = "Tạo câu hỏi thành công"
      redirect_to teachers_course_lesson_questions_path(@course, @lesson)
    else
      init_variable
      @answer = @question.answers.present? ? @question.answers : @question.answers.build
      render :index
    end
  end

  def show
    respond_to do |format|
      format.html{render partial: "details_information", local: {question: @question}}
    end
  end

  def edit; end

  def update
    if @question.update_attributes question_params
      create_activity_for_question
      flash[:success] = "Cập nhật câu hỏi thành công"
      redirect_to teachers_course_lesson_questions_path(@course, @lesson)
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      create_activity_for_question
      flash[:success] = "Xóa câu hỏi thành công"
    else
      flash[:warning] = "Xóa câu hỏi không thành công"
    end
    redirect_to teachers_course_lesson_questions_path(@course, @lesson)
  end

  private

  def question_params
    params.require(:question).permit(:name,
      answers_attributes: [:id, :name, :is_correct, :_destroy])
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to teachers_courses_path
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
    return if @lesson
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to teachers_course_lessons_path(@course)
  end

  def load_question
    @question = Question.find_by id: params[:id]
    return if @question
    flash[:error] = "Không tìm thấy bài học"
    redirect_to teachers_course_lesson_questions_path(@course, @lesson)
  end

  def create_activity_for_question
    create_activity Question.name, @question, @_action_name
  end

  def init_variable
    @questions = @lesson.questions.recent.page(params[:page])
      .per Settings.per_page.teachers.question
  end
end
