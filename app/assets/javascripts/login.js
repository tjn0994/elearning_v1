$(document).ready(function() {
  function group(class_name){
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
        'group[name]': {
          required: true,
          minlength: 2
        },
        'location_type[name]': {
          required: true,
          minlength: 2
        },
        'location_type[default_width]': {
          required: true,
          min: 50
        },
        'location_type[default_height]': {
          required: true,
          min: 50
        },
        'workspace[name]': {
          required: true,
          minlength: 2
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
            }
          }
        });
      }
    };
  }();

  Login.init();
});
