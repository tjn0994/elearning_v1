$(document).on('keyup', '#post_search', function(e) {
  $.get($('#post_search').attr('action'),
    $('#post_search').serialize(), null, 'script');
});

$(document).on('change', "#q_type_id_eq", function() {
  $.get($('#post_search').attr('action'),
    $('#post_search').serialize(), null, 'script');
});
