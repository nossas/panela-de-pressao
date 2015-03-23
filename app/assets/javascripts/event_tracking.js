$(function(){
  $("#GooglePlayButton").click(function(){
    _gaq.push(['_trackEvent', 'Fake Buttons', 'Download Android App']);
  });

  $("#AppStoreButton").click(function(){
    _gaq.push(['_trackEvent', 'Fake Buttons', 'Download iPhone App']);
  });
});
