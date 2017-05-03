$(document).ready(function(){
  $('.btn-edit-comment').on('click', function() {
    //console.log(this.closest('.comment-content'));
    $('.comment-content-'+ this.id).hide();
  });
});
