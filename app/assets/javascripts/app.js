var Routes = Backbone.Router.extend({

  routes: {
    "login" : "login",
    "poke"  : "poke"
  },
  poke: function(){
    $.facebox({div: '#poke_box', width: '900px'})
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
      $("select#campaign_user_id").chosen({no_results_text: "Nenhum resultado", width: "300px"});

      $('.phone_rj').inputmask("mask", {"mask": "(21) 999999999"});
      $('.phone_with_country_code').inputmask("mask", { "mask" : "+99 (99) 9999-9999"});

      $('section.index li.campaign:nth-child(4n+0)').css("margin-right", "0");
      $('section.explore li.campaign:nth-child(3n+0)').css("margin-right", "0");
      $('body.users#show li.campaign:nth-child(3n+0)').css("margin-right", "0");
      
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

      if(window.location.hash){
        $(window.location.hash).foundation('reveal', 'open');
      }

      if($("#poke_notice").length){ 
        $.facebox({ div: '#poke_notice'});
      }

      $('a[rel*=facebox]').facebox();
      $('a[rel*=facebox_fixed]').facebox();

      $(document).bind('reveal.facebox', function() {
        $("form.new_update").enableClientSideValidations();
        $("form.edit_update").enableClientSideValidations();
        loadShareButtons();
      });

      $('a.facebook_share_btn, a.twitter_share_btn').click(function(event, target){
        event.preventDefault();
        var obj = $(event.target);
        var url = null;
        url = obj.attr('href');
        if (url == undefined) {
          url = obj.parent('a').attr('href');
        }
        window.open(url, '', 'width=600,height=300');
      });

      function loadShareButtons(){
        $("a.facebook_share, a.twitter_share").click(function(event, target){
          event.preventDefault();
          var obj = $(event.target);
          var url = null;

          url = obj.attr('href');
          if (url == undefined) {
            url = obj.parent('a').attr('href');
          }

          window.open(url, '', 'width=600,height=300');
        });
      }
      loadShareButtons();
    },

    showLoginBox: function(){
      $.colorbox({ inline: true, href: '#login', width: "30%", height: "50%" });
    }
  }
};
