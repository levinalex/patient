$(function() {
	$("#accession_drawn_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
	$("#accession_received_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
	$("#departments").tabs();
	$("#order_tests").tabs();
	var $tabs = $('#lab_tests').tabs(), $panels = $('.ui-tabs-panel');
	$("tr.accession").hover(
                          function () {
                          $(this).append($("<td> patient_info</td>"));
                          },
                          function () {
                          $(this).find("td:last").remove();
                          });
  $("#sortable_lab_tests").sortable();
  $("li.contact").hover(
                        function () {
                        $(this).css({
                                    'background' : 'seashell'
                                    });
                        $(this).children(".tools").show();
                        },
                        function () {
                        $(this).css({
                                    'background' : 'white'
                                    });
                        $(this).children(".tools").hide();
                        });
  
  setTimeout(function(){ $("#flash").fadeOut(2000); }, 3000);
  
/*  function flash(type, sticky) {
 $("#flash").hide();
 if (type == "warning" || type == "error") {
 $("#flash").css({
 'color' : 'flash_warning';
 });
 } else {
 $("#flash").css({
 'color' : 'flash_notice';
 });
 }
 $("#flash").show(0.5);
 if (!sticky) {
 $("#flash").hide(3000);
 }
 };*/  
  
  $(document).ajaxSend(function(event, request, settings) {
                       if (typeof(AUTH_TOKEN) == "undefined") return;
                       // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
                       settings.data = settings.data || "";
                       settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
                       });
  
  $('ul.lab_tests').sortable({
                             items:'li.lab_test',
                             containment:'parent',
                             axis:'y',
                             update: function() {
                             $.post('/admin/lab_tests/sort', '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'));
                             }
                             });
/* Panels
 TODO: Refactor this ASAP!
*/
  
  function toggleStatus() {
	if ($('#panel_1').is(':checked')) {
  $('#lab_test_1').attr('disabled', true);
  $('#lab_test_2').attr('disabled', true);
  $('#lab_test_3').attr('disabled', true);
  $('#lab_test_4').attr('disabled', true);
  $('#lab_test_5').attr('disabled', true);
  $('#lab_test_6').attr('disabled', true);
  $('#lab_test_7').attr('disabled', true);
  $('#lab_test_8').attr('disabled', true);
  $('#lab_test_9').attr('disabled', true);
  $('#lab_test_10').attr('disabled', true);
  $('#lab_test_11').attr('disabled', true);
  $('#lab_test_12').attr('disabled', true);
  $('#lab_test_13').attr('disabled', true);
  $('#lab_test_14').attr('disabled', true);
	} else {
  $('#lab_test_1').removeAttr('disabled');
  $('#lab_test_2').removeAttr('disabled');
  $('#lab_test_3').removeAttr('disabled');
  $('#lab_test_4').removeAttr('disabled');
  $('#lab_test_5').removeAttr('disabled');
  $('#lab_test_6').removeAttr('disabled');
  $('#lab_test_7').removeAttr('disabled');
  $('#lab_test_8').removeAttr('disabled');
  $('#lab_test_9').removeAttr('disabled');
  $('#lab_test_10').removeAttr('disabled');
  $('#lab_test_11').removeAttr('disabled');
  $('#lab_test_12').removeAttr('disabled');
  $('#lab_test_13').removeAttr('disabled');
  $('#lab_test_14').removeAttr('disabled');
	}
	if ($('#panel_2').is(':checked')) {
  $('#lab_test_15').attr('disabled', true);
  $('#lab_test_16').attr('disabled', true);
  $('#lab_test_17').attr('disabled', true);
  $('#lab_test_18').attr('disabled', true);
  $('#lab_test_19').attr('disabled', true);
  $('#lab_test_20').attr('disabled', true);
  $('#lab_test_21').attr('disabled', true);
  $('#lab_test_22').attr('disabled', true);
  $('#lab_test_23').attr('disabled', true);
	} else {
  $('#lab_test_15').removeAttr('disabled');
  $('#lab_test_16').removeAttr('disabled');
  $('#lab_test_17').removeAttr('disabled');
  $('#lab_test_18').removeAttr('disabled');
  $('#lab_test_19').removeAttr('disabled');
  $('#lab_test_20').removeAttr('disabled');
  $('#lab_test_21').removeAttr('disabled');
  $('#lab_test_22').removeAttr('disabled');
  $('#lab_test_23').removeAttr('disabled');
	}
	if ($('#panel_3').is(':checked')) {
  $('#lab_test_38').attr('disabled', true);
  $('#lab_test_39').attr('disabled', true);
  $('#lab_test_57').attr('disabled', true);
  $('#lab_test_43').attr('disabled', true);
  $('#lab_test_44').attr('disabled', true);
  $('#lab_test_45').attr('disabled', true);
  $('#lab_test_46').attr('disabled', true);
  $('#lab_test_47').attr('disabled', true);
  $('#lab_test_48').attr('disabled', true);
  $('#lab_test_26').attr('disabled', true);
  $('#lab_test_58').attr('disabled', true);
  $('#lab_test_59').attr('disabled', true);
  $('#lab_test_60').attr('disabled', true);
  $('#lab_test_61').attr('disabled', true);
  $('#lab_test_62').attr('disabled', true);
  $('#lab_test_63').attr('disabled', true);
  $('#lab_test_64').attr('disabled', true);
  $('#lab_test_65').attr('disabled', true);
  $('#lab_test_69').attr('disabled', true);
	} else {
  $('#lab_test_38').removeAttr('disabled');
  $('#lab_test_39').removeAttr('disabled');
  $('#lab_test_57').removeAttr('disabled');
  $('#lab_test_43').removeAttr('disabled');
  $('#lab_test_44').removeAttr('disabled');
  $('#lab_test_45').removeAttr('disabled');
  $('#lab_test_46').removeAttr('disabled');
  $('#lab_test_47').removeAttr('disabled');
  $('#lab_test_48').removeAttr('disabled');
  $('#lab_test_26').removeAttr('disabled');
  $('#lab_test_58').removeAttr('disabled');
  $('#lab_test_59').removeAttr('disabled');
  $('#lab_test_60').removeAttr('disabled');
  $('#lab_test_61').removeAttr('disabled');
  $('#lab_test_62').removeAttr('disabled');
  $('#lab_test_63').removeAttr('disabled');
  $('#lab_test_64').removeAttr('disabled');
  $('#lab_test_65').removeAttr('disabled');
  $('#lab_test_69').removeAttr('disabled');
	}
  }

  $("#panel_1").click(toggleStatus);
  $("#panel_2").click(toggleStatus);
  $("#panel_3").click(toggleStatus);
  });
