// $(document).ready(function() {
//   setInterval('load_time()', 1000);
// });

// function load_time(){
//   gon.courses.forEach(function(val) {
//     time = "#time-" + val.course_id;
//     date = new Date();
//     date_time = new Date(format_date_time(val.date_close)) - new Date(format_date_time_current(date));
//     startTime(new Date(date_time), time);
//   });
// }

// function startTime(date_time, time_id) {
//   var h = date_time.getHours();
//   var m = date_time.getMinutes();
//   var s = date_time.getSeconds();
//   time = checkTime(h) + ":" + checkTime(m) + ":" + checkTime(s);
//   $(time_id).html(time);
// }

function checkTime(i) {
  if (i < 10) {
    i = "0" + i;
  }
  return i;
}

// function format_date_time(date) {
//   return moment(date).endOf('day').format('MM/DD/YYYY HH:mm:ss');
// }

// function format_date_time_current(date) {
//   return moment(date).format('MM/DD/YYYY HH:mm:ss');
// }

$(document).ready(function() {
  // Set the date we're counting down to
  gon.courses.forEach(function(val){
    countDownDate = new Date(val.date_close).setHours(23,59,59,999);
    time_id = "#time-" + val.course_id;
    // Update the count down every 1 second
    course_id = val.course_id;
    setIntervalTimeRegister(countDownDate, time_id, course_id);
  });
});

function setIntervalTimeRegister(countDownDate, time_id, course_id){
  course_id = setInterval(function() {

      // Get todays date and time
      var now = new Date().getTime();

      // Find the distance between now an the count down date
      var distance = countDownDate - now;

      // Time calculations for days, hours, minutes and seconds
      var days = Math.floor(distance / (1000 * 60 * 60 * 24));
      var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((distance % (1000 * 60)) / 1000);

      // Display the result in the element with id="demo"
      time = days + " ngày " + checkTime(hours) + ":" + checkTime(minutes) + ":" + checkTime(seconds);
      $(time_id).html(time);
      if (distance < 0) {
        clearInterval(course_id);
        $('#table-' + course_id).hide();
      }


      // If the count down is finished, write some text

    }, 1000);
}
