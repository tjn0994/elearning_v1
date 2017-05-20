$(document).on('keyup', '#course_search', function(e) {
  $.get($('#course_search').attr('action'),
    $('#course_search').serialize(), null, 'script');
});

$(document).ready(function(){
  $('#refresh-page-course').on('click', function(e){
    window.location.reload(true);
  });
});

$(document).on('change', "#q_type_id_eq", function() {
  $.get($('#course_search').attr('action'),
    $('#course_search').serialize(), null, 'script');
});

$(document).ready(function(){
  $('.tooltip-teacher-course').hover(function(e) {
    this.title = $(".tooltip-teacher-course option:selected").text();
  });

  $(".tooltip-teacher-course").tooltip({
    left: 25
  });
});
