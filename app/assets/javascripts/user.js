$(document).ready(function() {
  $('#user_avatar').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert("image qua lon");
      $('#user_avatar').val("");
    }
  });

  $("#user_avatar").change(function(){
    $('#img_prev').removeClass('hidden');
    readURL(this);
  });
});

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#img_prev').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}
