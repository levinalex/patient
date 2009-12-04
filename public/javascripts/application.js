$(function() {
	$("#accession_drawn_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
	$("#accession_received_at").datepicker({maxDate: 0, showOn: 'button', buttonImage: '/images/calendar.gif', buttonImageOnly: true});
	$("#departments").tabs();
	$("#order_tests").tabs();
	var $tabs = $('#lab_tests').tabs(), $panels = $('.ui-tabs-panel');
  $(".lab_tests").sortable({handle: '.handle', axis: 'y', update: function() {
                           $.post('/admin/lab_tests/sort', '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'))
                           }}).disableSelection();
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
