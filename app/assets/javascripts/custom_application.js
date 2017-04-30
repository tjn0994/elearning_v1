$(document).ready(function() {
  // category course
  $('#category-id-post').on('change', function(e) {
    $.ajax({
      type: 'GET',
      url: '/admins/categories/' + this.value,
      data: {id: this.value, name: "Post"},
      success: function(data) {
        $('#types').html(data);
      },
      error: function(){
        alert("error");
      }
    })
  });

  // user seting
  $('#student_notification_setting').on('change', function(e) {
    $.ajax({
      dataType: 'json',
      url: location.pathname,
      method: 'get',
      data: {notify_setting: this.checked},
      success: function(data) {

      }
    })
  });

  $('#student_email_setting').on('change', function(e) {
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
