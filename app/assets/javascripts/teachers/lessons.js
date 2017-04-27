$(document).ready(function(){
  $('.add-time-exam').on('click', function(){
    $('#time_for_exam_lesson_id').val($(this).attr("data-id"));
  });
});
