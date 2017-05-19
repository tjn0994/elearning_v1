$(document).on('keyup', '#user_course_search', function(e) {
  $.get($('#user_course_search').attr('action'),
    $('#user_course_search').serialize(), null, 'script');
});

$(document).on('change', "#q_status_eq", function() {
  $.get($('#user_course_search').attr('action'),
    $('#user_course_search').serialize(), null, 'script');
});
