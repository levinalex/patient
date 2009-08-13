$(function() {
  $("#accession_received_at").datepicker();
  $("#accession_drawn_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
  $("#lab_tests").tabs({ event: 'mouseover' });
  var $tabs = $('#lab_tests').tabs(), $panels = $('.ui-tabs-panel');
  var maxHeight =
    $.map($panels, function(el) {
      return $(el).height();;
    })
    .sort(function(a, b) {
      return b - a;
    })[0];
  $panels.height(maxHeight);
  $("tr.accession").hover(
                 function () {
                 $(this).append($("<td> patient_info</td>"));
                 },
                 function () {
                 $(this).find("td:last").remove();
                 });
});
