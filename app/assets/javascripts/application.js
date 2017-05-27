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
//= require plugins
//= require modernizr-2.7.1-respond-1.4.2.min
//= require jquery-1.11.1.min
//= require app
//= require portfolio
//= require bootstrap-datepicker

//= require user.js
//= require date.js
//= require custom_application.js

//gem ckeditor
//= require ckeditor/init
//= require ckeditor_custom

// gem validate
//= require login.js
//= require jquery.validate

// gem ratyrate
//= require jquery.raty
//= require ratyrate

// gem social-share-button
//= require social-share-button

// gem "chartkick"
//= require chartkick

//= require cable

//= require ./member/posts.js
//= require ./member/comments.js

$(document).ready(function() {
  $('#flash-message').delay(2000).slideUp(500, function() {
    $(this).remove();
  });
});
