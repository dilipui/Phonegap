// disable ajax navigation, it seems buggy
// make sure jquery.mobile is included after this
$(document).bind('mobileinit', function () {
  $.mobile.ajaxEnabled = false;
});
