class Teachers::TimeForExamsController < DashboardController
  def new
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @time_for_exam = TimeForExam.new time_for_exam_params
    if @time_for_exam.save
      respond_to do |format|
        format.js{}
      end
    else
      render :new
    end
  end

  private

  def time_for_exam_params
    params.require(:time_for_exam).permit(:lesson_id, :time, :number_question)
  end

  def create_activity_for_time_exam
    create_activity TimeForExam.name, @time_for_exam, @_action_name
  end
end
