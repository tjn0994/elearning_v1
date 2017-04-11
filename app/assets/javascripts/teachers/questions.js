function change_label_relax(class_form_relax) {
  $(class_form_relax).not('[style]').find('.kakaka ').each(function(index){
    label = 'Answer ' + (index + 1);
    $(this).text(label)
  });
}

$(document).on('click', '.add-answer', function() {
  change_label_relax('.answers-form');
});

$(document).on('click', '.remove-answer', function() {
  change_label_relax('.answers-form');
});
