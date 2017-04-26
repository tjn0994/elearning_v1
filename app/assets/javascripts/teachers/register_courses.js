$(document).ready(function(){
  $('.register-course').on('click', function(){
    $('#register_course_course_id').val($(this).attr("data-id"));
  });
});
