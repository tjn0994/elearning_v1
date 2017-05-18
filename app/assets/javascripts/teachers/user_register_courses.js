$(document).on('keyup', '#user_course_search', function(e) {
  $.get($('#user_course_search').attr('action'),
    $('#user_course_search').serialize(), null, 'script');
});

$(document).on('change', "#q_status_eq", function() {
  $.get($('#user_course_search').attr('action'),
    $('#user_course_search').serialize(), null, 'script');
});

$(document).on('change', "#q_course_id_eq", function() {
  $.get($('#user_course_search').attr('action'),
    $('#user_course_search').serialize(), null, 'script');
});

$(document).ready(function(){
  $('#tooltip-course').hover(function(e) {
    this.title = $("#tooltip-course option:selected").text();
  });

  $("#tooltip-course").tooltip({
    left: 25
  });
});
