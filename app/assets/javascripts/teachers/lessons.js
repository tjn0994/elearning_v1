$(document).on('keyup', '#lesson_search', function(e) {
  $.get($('#lesson_search').attr('action'),
    $('#lesson_search').serialize(), null, 'script');
});

$(document).ready(function(){
  $('#refresh-page-lesson').on('click', function(e){
    window.location.reload(true);
  });
});
