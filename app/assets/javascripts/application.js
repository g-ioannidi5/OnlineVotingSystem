// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// Loads all Bootstrap javascripts
//= require bootstrap
//= require bootstrap-scrollspy
//= require bootstrap-modal
//= require bootstrap-dropdown
//= require highcharts
//= require modules/exporting
//= require bootstrap-alert
//= require_tree .


$(function () {
  if ($('#view_responses.html').length > 0) {
    setTimeout(updateComments, 10000);
  }
});

function updateComments() {
  $.getScript('/view_responses.html.js');
  setTimeout(updateComments, 10000);
}

