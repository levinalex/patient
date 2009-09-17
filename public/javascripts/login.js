$(function() {
  $("div#login form :input:visible:first").focus();
  $("#errorExplanation").ready(
                               function () {
                               $("#errorExplanation").effect("shake", { times:3, distance:10 }, 60);
                               });
  });
