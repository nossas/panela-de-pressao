var Routes = Backbone.Router.extend({

  routes: {
    "login" : "login",
  },

  login: function(){
    App.Common.showLoginBox();
    this.navigate("");
  }
});

var App = window.App = {
  // Put other existing namespaces here
  Common: {
    init: function(){
      var route = new Routes();     
      Backbone.history.start();


      $(".chzn-select").chosen({no_results_text: "Nenhum resultado"});
      $('#campaign_twitter_text').textareaCount({maxCharacterSize: 100}, function(data){
        $(".campaign_twitter_text_status").html(100 - data.input + " caracteres");
      });

      // FB share
      (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=419565954732160";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));

      // Twitter share
      !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");

      // Google share
      window.___gcfg = {lang: 'pt-BR'};
      (function() {
        var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
        po.src = 'https://apis.google.com/js/plusone.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
      })();

      // Google analytics
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-26278513-4']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    },

    showLoginBox: function(){
      $.facebox.settings.closeImage = '/assets/closelabel.png';
      $.facebox.settings.loadingImage = '/assets/loading.gif';
      $.facebox({ div: '#login' });
    },

    finish: function(){
    },
  }
};
