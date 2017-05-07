$(document).on('keyup', '#new_comment', function(e) {
  if($('#comment_content').val() != ""){
    if(e.keyCode == 13){
      $.get($('#new_comment').attr('action'),
        $('#comment_content').serialize(), null, 'script');
    }
  }
});
