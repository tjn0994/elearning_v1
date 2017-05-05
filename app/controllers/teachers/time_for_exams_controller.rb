class Teachers::TimeForExamsController < DashboardController
  def new
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @lesson = Lesson.find_by id: params[:lesson_id]
    @time_for_exam = TimeForExam.new time_for_exam_params.merge! lesson_id: @lesson.id
    if @time_for_exam.save
      respond_to do |format|
        format.js{}
      end
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js{}
    end
  end

  def update
    @lesson = Lesson.find_by id: params[:lesson_id]
    if @lesson.time_for_exam.update_attributes time_for_exam_params.merge! lesson_id: @lesson.id
      respond_to do |format|
        format.js{}
      end
    else
      @time_for_exam = @lesson.time_for_exam
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
end
