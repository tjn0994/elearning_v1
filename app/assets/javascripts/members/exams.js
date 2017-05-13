$(document).ready(function() {
  setInterval('startTimeExam(time)', 1000);
});

var time = new Date(gon.time);
var h = time.getHours();
var m = time.getMinutes();
var s = time.getSeconds();
function startTimeExam() {
  time_exam = checkTime(h) + ":" + checkTime(m) + ":" + checkTime(s);
  $("#time-exam-of-member").html(time_exam);
  if(s == 0){
    if (h == 0 && m == 0){
      return $(".auto-submit-exam").click();
    } else {
      if(m == 0){
        h = h - 1;
        m = 59;
        s = 59;
      } else {
        m = m -1;
        s = 59;
      }
    }
  } else {
    s = s - 1;
  }
}

function checkTime(i) {
  if (i < 10) {
    i = "0" + i;
  }
  return i;
}
