$(function() {
	$("#accession_drawn_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
	$("#accession_received_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
	$("#departments").tabs();
	$("#order_tests").tabs();
	var $tabs = $('#lab_tests').tabs(), $panels = $('.ui-tabs-panel');
  $("#sortable_lab_tests").sortable();
  $("li.contact").live("mouseover", function () {
                        $(this).css({
                                    'background' : 'seashell'
                                    });
                        $(this).children(".tools").show();
                       });
  $("li.contact").live("mouseout", function () {
                        $(this).css({
                                    'background' : 'white'
                                    });
                        $(this).children(".tools").hide();
                        });
  
  setTimeout(function(){ $("#flash").fadeOut(2000); }, 3000);
});
