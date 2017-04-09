function change_label_relax(class_form_relax) {
  $(class_form_relax).not('[style]').find('.relax-label span').each(function(index){
    label = 'Relax ' + (index + 1) + ':';
    $(this).text(label)
  });
}

$(document).on('click', '.add-relax', function() {
  change_label_relax('.relax-form');
});

$(document).on('click', '.remove-relax', function() {
  change_label_relax('.relax-form');
});

$(document).on('click', '.add-timesheet', function() {
  change_label_relax('.timesheets-form');
});

$(document).on('click', '.remove-relax-update', function() {
  change_label_relax('.timesheets-form');
});
