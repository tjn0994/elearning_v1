$(document).ready(function() {

  // category course
  $('#category-id').on('change', function(e) {
    $.ajax({
      type: 'GET',
      url: '/admins/categories/' + this.value,
      data: {id: this.value, name: "Course"},
      success: function(data) {
        $('#types').html(data);
      },
      error: function(){
        alert("error");
      }
    })
  });

  // model show
  $('.btn-show-request').on('click', function(e) {
    $.ajax({
      dataType: 'html',
      url: $(this).data('request'),
      method: 'get',
      success: function(data) {
        $('.modal-body-show-request').html(data);
        $('.show-request').show();
      },
      error: function(){
        alert("error");
      }
    })
  });

  $('.close-modal').on('click', function(e){
    $('.show-request').hide();
  });

  // user seting
  $('#notification_setting').on('change', function(e) {
    $.ajax({
      dataType: 'json',
      url: location.pathname,
      method: 'get',
      data: {notify_setting: this.checked},
      success: function(data) {

      }
    })
  });

  $('#email_setting').on('change', function(e) {
    $.ajax({
      dataType: 'json',
      url: location.pathname,
      method: 'get',
      data: {email_setting: this.checked},
      success: function(data) {
      }
    })
  });
});

function search_add_user(_search_input, class_name, class_hide_name){
  $(_search_input).on("keyup", function(){
    var g = $(this).val().toLowerCase();
    $(class_name).each(function(){
      var s = $(this).text().toLowerCase();
      $(this).closest(class_hide_name)
        [ s.indexOf(g) !== -1 ? 'show' : 'hide' ]();
      if(s.indexOf(g) !== -1){
        $(this).removeClass("search-checkbox");
        $(this).addClass("search-checkbox");
      }
      else{
        $(this).removeClass("search-checkbox");
      }
    });
  });
}
