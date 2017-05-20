$(document).on('keyup', '#user_search', function(e) {
  $.get($('#user_search').attr('action'),
    $('#user_search').serialize(), null, 'script');
});

$(document).ready(function(){
  $('#refresh-page-list-user').on('click', function(e){
    window.location.reload(true);
  });
});

$(document).on('change', "#q_role_eq", function() {
  $.get($('#user_search').attr('action'),
    $('#user_search').serialize(), null, 'script');
});

