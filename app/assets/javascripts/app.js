var Routes = Backbone.Router.extend({

  routes: {
    "login" : "login",
    "poke"  : "poke"
  },
  poke: function(){
    $.colorbox({inline: true, width: '900px', href: '#poke_box'})
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
      $("#user_mobile_phone").inputmask("mask", {"mask": "(99) 9999-9999"});
      $('.phone').inputmask("mask", {"mask": "(99) 9999-9999"});
      $('#campaign_twitter_text').textareaCount({maxCharacterSize: 100}, function(data){
        $(".campaign_twitter_text_status").html(100 - data.input + " caracteres");
      });
      if ($.browser.msie !== undefined) {
        $('section.index li.campaign:nth-child(4n+0)').css("margin-right", "0");
        $('section.explore li.campaign:nth-child(3n+0)').css("margin-right", "0");
        $('body.users#show li.campaign:nth-child(3n+0)').css("margin-right", "0");
      }
      
      $('ul.current li.me').on('click', function(){ $(this).children('.options').fadeToggle(10); });


      // FB share
      (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=" + $("meta[name='facebook_app_id']").attr('content');
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



      if($("#poke_notice").length){ 
        $.colorbox({ href: "#poke_notice", inline: true, width: "50%" }); 
      }

      $('a[rel*=facebox]').colorbox({ inline: true, width: "50%" });
      $('a[rel*=facebox_fixed]').colorbox({ inline: true, width: "800px" });
    },

    showLoginBox: function(){
      $.colorbox({ inline: true, href: '#login', width: "30%", height: "50%" });
    }
  }
};
