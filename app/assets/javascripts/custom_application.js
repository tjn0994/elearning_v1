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
});
