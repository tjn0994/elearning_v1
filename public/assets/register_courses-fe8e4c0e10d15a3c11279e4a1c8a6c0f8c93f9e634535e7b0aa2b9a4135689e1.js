$(document).ready(function() {
  setInterval('load_time()', 1000);
});

function load_time(){
  gon.courses.forEach(function(val) {
    time = "#time-" + val.course_id;
    date = new Date();
    date_time = new Date(format_date_time(val.date_close)) - new Date(format_date_time(date));
    startTime(new Date(date_time), time);
  });
}

function startTime(date_time, time_id) {
  var h = date_time.getHours();
  var m = date_time.getMinutes();
  var s = date_time.getSeconds();
  time = checkTime(h) + ":" + checkTime(m) + ":" + checkTime(s);
  $(time_id).html(time);
}

function checkTime(i) {
  if (i < 10) {
    i = "0" + i;
  }
  return i;
}

function format_date_time(date) {
  return moment(date).format('MM/DD/YYYY HH:mm:ss');
}
;
