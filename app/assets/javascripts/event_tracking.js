$(function(){
  $("#GooglePlayButton").click(function(){
    ga('send', 'event', 'Fake Buttons', 'Download Android App');
  });

  $("#AppStoreButton").click(function(){
    ga('send', 'event', 'Fake Buttons', 'Download iPhone App');
  });
});
