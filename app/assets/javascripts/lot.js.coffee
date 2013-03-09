# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $('.show-results').click ->
    $.ajax url: "/lab/lots/" + $(this).data("lot-id") + "/lot_versions/" + $(this).data("lot-version-id") + "/show_results.js"
    
  $('.set-version').change ->
    $('#_stamp_row_' +  $(this).data("row")).val( $(this).data("id") )
  