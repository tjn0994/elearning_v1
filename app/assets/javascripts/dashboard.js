// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap/modal
//= require portfolio.js
//= require ./dashboard/app.js
//= require ./dashboard/plugins.js
//= require ./dashboard/vendor/jquery-1.11.1.min.js
//= require ./dashboard/vendor/bootstrap.min.js
//= require ./dashboard/vendor/modernizr-2.7.1-respond-1.4.2.min.js
//= require bootstrap-datepicker
//= require moment
//= require bootstrap-datetimepicker
//= require cable

//= require ckeditor/init
//= require ckeditor_custom

//= require user.js
//= require custom_dashboard.js
//= require date.js
//= require ./teachers/questions.js
//= require ./teachers/lessons.js
//= require ./teachers/courses.js
//= require ./teachers/user_courses.js

// gem validate
//= require login.js
//= require jquery.validate

$(document).ready(function() {
  $('#flash-message').delay(2000).slideUp(500, function() {
    $(this).remove();
  });
});

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("true");
  $(link).closest('.timesheets-form').hide();
}

function remove_fields_answer(link) {
  $(link).prev("input[type=hidden]").val("true");
  $(link).closest('.answers-form').hide();
}

function remove_fields_type(link) {
  $(link).prev("input[type=hidden]").val("true");
  $(link).closest('.types-form').hide();
}
