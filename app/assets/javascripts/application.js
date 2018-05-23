// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require_tree .

var actionChecker;

function doneChecking () {
  clearInterval(actionChecker);
}

function checkLastAction () {
  // Get the game ID from the html access span
  var dataId = document.getElementById('javascript_data_access');
  if (!dataId) return doneChecking();
  var initActionTime = dataId.getAttribute('init_last_action_time');
  if (!initActionTime) return doneChecking();

  dataId = dataId.getAttribute('game_number');
  if (!dataId) return doneChecking();

  // Get the last action time
  var ret = $.getJSON("/get_last_action_time/"+dataId, function (data) {
    var lastActionTime = data.last_action_time;
    if (!lastActionTime) return doneChecking();
    if (lastActionTime>initActionTime) {
      location.reload();
    }
  })
}

window.onload = function() {
  // Check every 1 second, shouldn't be too short due to performance
  actionChecker = setInterval(checkLastAction, 1000);
}
