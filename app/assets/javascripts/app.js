var App = window.App = {
  // Put other existing namespaces here
  Common: {
    init: function(){
      $(".chzn-select").chosen({no_results_text: "Nenhum resultado"});
      $('#campaign_twitter_text').textareaCount({maxCharacterSize: 100}, function(data){
        $(".campaign_twitter_text_status").html(100 - data.input + " caracteres");
      });
    },

    finish: function(){
    },
  }
};
