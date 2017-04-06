$(document).ready(function() {
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
});
