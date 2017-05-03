class RegisterCourseJob < ApplicationJob
  queue_as :default

  def perform register_course
    register_course.update status: RegisterCourse.statuses[:active]
    delay_job = Delayed::Job.find delayed_reference_id: register_course.id
    if delay_job.blank?
      Delayed::Job.create run_at: register_course.date_open, locked_at: register_course.date_close,
        delayed_reference_id: register_course.id, delayed_reference_type: register_course.course.name
    else
      delay_job.update_attributes run_at: register_course.date_open, locked_at: register_course.date_close
    end
  end
end
