function change_label_relax(class_form_relax) {
  $(class_form_relax).not('[style]').find('.kakaka').each(function(index){
    label = 'Đáp án ' + (index + 1);
    $(this).text(label)
  });
}

$(document).on('click', '.add-answer', function() {
  change_label_relax('.answers-form');
});

$(document).on('click', '.remove-answer', function() {
  change_label_relax('.answers-form');
});

$(document).on('keyup', '#question_search', function(e) {
  $.get($('#question_search').attr('action'),
    $('#question_search').serialize(), null, 'script');
});

$(document).ready(function(){
  $('#refresh-page').on('click', function(e){
    window.location.reload(true);
  });
});
