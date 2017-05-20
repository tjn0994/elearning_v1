$(document).on('keyup', '#category_search', function(e) {
  $.get($('#category_search').attr('action'),
    $('#category_search').serialize(), null, 'script');
});

$(document).ready(function(){
  $('#refresh-page-list-user').on('click', function(e){
    window.location.reload(true);
  });
});
