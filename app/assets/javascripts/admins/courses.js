$(document).on('keyup', '#course_search', function(e) {
  $.get($('#course_search').attr('action'),
    $('#course_search').serialize(), null, 'script');
});

$(document).ready(function(){
  $('#refresh-page-list-user').on('click', function(e){
    window.location.reload(true);
  });
});

$(document).on('change', "#q_status_eq", function() {
  $.get($('#course_search').attr('action'),
    $('#course_search').serialize(), null, 'script');
});
