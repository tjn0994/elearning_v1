$(document).ready(function(){
  var checkedValues;
  $('.btn-delete-member').prop('disabled', true);
  $('.btn-add-member-into-course').prop('disabled', true);

  $('.checkbox-member input[type=checkbox]').on('click', function(e){
    checkedValues = $('.checkbox-member input:checkbox:checked').map(function() {
      return this.value;
    }).get();
    if(checkedValues.length > 0){
      $('.btn-delete-member').prop('disabled', false);
    } else {
      $('.btn-delete-member').prop('disabled', true);
    }
  });

  search_add_user('#assign-user-to-special-type-search', '.new-user-course', '.hide-class-user-course');
  diasble_button('#add-member input[type=checkbox]',
    '#add-member input[type=checkbox]:checked',
    '.btn-add-member-into-course');
});

function diasble_button(obj, action, btn){
  $(document).on('change', obj, function() {
    var x = $(action).length
    if(x === 0)
      $(btn).prop('disabled', true);
    else
      $(btn).prop('disabled', false);
  });
}
