$(function() {
  $(".pagination a").live("click", function() {
                          $("#paging").show();
                          $.getScript(this.href);
                          return false;
                          });
  });
