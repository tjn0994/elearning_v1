$(document).ready(function() {
  function validate_post(class_name){
    $(class_name).validate({
      errorClass: 'help-block animation-slideDown',
      errorElement: 'div',
      errorPlacement: function(error, e) {
        e.parents('.form-group > div').append(error);
      },
      highlight: function(e) {
        $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
        $(e).closest('.help-block').remove();
      },
      success: function(e) {
        e.closest('.form-group').removeClass('has-success has-error');
        e.closest('.help-block').remove();
      },
      rules: {
        'post[title]': {
          required: true,
          minlength: 2,
          maxlength: 255
        },
        'post[content]': {
          required: true
        }
      },
      messages: {
        'post[title]': {
          required: "Tiêu đề không được để trống",
          minlength: "Tiêu đề ít nhất 2 ký tự",
          maxlength: "Tiêu đề tối đa 255 ký tự"
        },
        'post[content]': {
          required: "Nội dung không được để trống"
        }
      }
    });
  }

  function validate_lesson(class_name){
    $(class_name).validate({
      errorClass: 'help-block animation-slideDown',
      errorElement: 'div',
      errorPlacement: function(error, e) {
        e.parents('.form-group > div').append(error);
      },
      highlight: function(e) {
        $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
        $(e).closest('.help-block').remove();
      },
      success: function(e) {
        e.closest('.form-group').removeClass('has-success has-error');
        e.closest('.help-block').remove();
      },
      rules: {
        'lesson[name]': {
          required: true,
          minlength: 2,
          maxlength: 255
        },
        'lesson[description]': {
          maxlength: 255
        }
      },
      messages: {
        'lesson[name]': {
          required: "Tên không được để trống",
          minlength: "Tên ít nhất 2 ký tự",
          maxlength: "Tên tối đa 255 ký tự"
        },
        'lesson[description]': {
          maxlength: "Mô tả tối đa 255 ký tự"
        }
      }
    });
  }

  function validate_register_course(class_name){
    $(class_name).validate({
      errorClass: 'help-block animation-slideDown',
      errorElement: 'div',
      errorPlacement: function(error, e) {
        e.parents('.form-group > div').append(error);
      },
      highlight: function(e) {
        $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
        $(e).closest('.help-block').remove();
      },
      success: function(e) {
        e.closest('.form-group').removeClass('has-success has-error');
        e.closest('.help-block').remove();
      },
      rules: {
        'register_course[date_open]': {
          required: true
        },
        'register_course[date_close]': {
          required: true
        }
      },
      messages: {
        'register_course[date_open]': {
          required: "Ngày bắt đầu không được để trống"
        },
        'register_course[date_close]': {
          required: "Ngày kết thúc không được để trống"
        }
      }
    });
  }

  function validate_time_for_exam(class_name){
    $(class_name).validate({
      errorClass: 'help-block animation-slideDown',
      errorElement: 'div',
      errorPlacement: function(error, e) {
        e.parents('.form-group > div').append(error);
      },
      highlight: function(e) {
        $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
        $(e).closest('.help-block').remove();
      },
      success: function(e) {
        e.closest('.form-group').removeClass('has-success has-error');
        e.closest('.help-block').remove();
      },
      rules: {
        'time_for_exam[number_question]': {
          required: true
        }
      },
      messages: {
        'time_for_exam[number_question]': {
          required: "Số câu hỏi không được để trống"
        }
      }
    });
  }

  var Login = function() {
    return {
      init: function() {
        /* Login form - Initialize Validation */
        $('#new_user').validate({
          errorClass: 'help-block animation-slideDown', // You can change the animation class for a different entrance animation - check animations page
          errorElement: 'div',
          errorPlacement: function(error, e) {
            e.parents('.form-group > div').append(error);
          },
          highlight: function(e) {
            $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
            $(e).closest('.help-block').remove();
          },
          success: function(e) {
            e.closest('.form-group').removeClass('has-success has-error');
            e.closest('.help-block').remove();
          },
          rules: {
            'user[name]': {
              required: true,
              minlength: 2
            },
            'user[email]': {
              required: true,
              email: true
            },
            'user[password]': {
              required: true,
              minlength: 6
            },
            'user[password_confirmation]': {
              required: true,
              minlength: 6,
              equalTo: '#user_password'
            }
          }
        });

        // validate password changed in gem devise
        $('#edit_user').validate({
          errorClass: 'help-block animation-slideDown', // You can change the animation class for a different entrance animation - check animations page
          errorElement: 'div',
          errorPlacement: function(error, e) {
            e.parents('.form-group > div').append(error);
          },
          highlight: function(e) {
            $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
            $(e).closest('.help-block').remove();
          },
          success: function(e) {
            e.closest('.form-group').removeClass('has-success has-error');
            e.closest('.help-block').remove();
          },
          rules: {
            'user[password]': {
              required: true,
              minlength: 6
            },
            'user[password_confirmation]': {
              required: true,
              minlength: 6,
              equalTo: '#user_password'
            },
            'user[current_password]': {
              required: true,
              minlength: 6
            }
          }
        });

        // validate form edit user
        $('.edit_user').validate({
          errorClass: 'help-block animation-slideDown',
          errorElement: 'div',
          errorPlacement: function(error, e) {
            e.parents('.form-group > div').append(error);
          },
          highlight: function(e) {
            $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
            $(e).closest('.help-block').remove();
          },
          success: function(e) {
            e.closest('.form-group').removeClass('has-success has-error');
            e.closest('.help-block').remove();
          },
          rules: {
            'user[name]': {
              required: true,
              minlength: 2
            },
            'user[email]': {
              required: true,
              email: true
            },
            'user[number_of_phone]': {
              required: true
            }
          }
        });

        // validate post
        validate_post(".edit_post");
        validate_post(".new_post");

        //validate lesson
        validate_lesson(".edit_lesson");
        validate_lesson(".new_lesson");

        validate_register_course(".edit_register_course");
        validate_register_course(".new_register_course");

        validate_time_for_exam(".new_time_for_exam");
        validate_time_for_exam(".edit_time_for_exam");
      }
    };
  }();

  Login.init();
});
