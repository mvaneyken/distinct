$ ->
  # Bootstrap-Datepicker
  $(document).on('focus', "[data-behaviour~='datepicker']", 
      (e) ->
        $(this).datepicker({'format': 'yyyy-mm-dd', 'weekStart': 0, 'autoclose': true, 'startDate': null, 'setValue': $(this).val()})
        )