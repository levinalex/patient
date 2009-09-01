$(function() {
  $("#accession_drawn_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
  $("#accession_received_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
  $("#order_tests").tabs({ event: 'mouseover' });
  var $tabs = $('#lab_tests').tabs(), $panels = $('.ui-tabs-panel');
  $("tr.accession").hover(
                 function () {
                 $(this).append($("<td> patient_info</td>"));
                 },
                 function () {
                 $(this).find("td:last").remove();
                 });
  $("#sortable_lab_tests").sortable();
  $('#errorExplanation').ready(
                    function () {
                               $("#new_user_session").effect("shake", { times:3, distance:10 }, 60);
                    });

  function toggleStatus() {
    if ($('#lab_test_panel_1').is(':checked')) {
      $('#lab_test_1').attr('disabled', true);
      $('#lab_test_2').attr('disabled', true);
      $('#lab_test_3').attr('disabled', true);
    } else {
      $('#lab_test_1').removeAttr('disabled');
      $('#lab_test_2').removeAttr('disabled');
      $('#lab_test_3').removeAttr('disabled');
    }
  }
  $("#lab_test_panel_1").click(toggleStatus);
  $("#lab_test_panel_2").click(function() {
                               $.getScript(this.href);
                               return false;
                               });  
});
