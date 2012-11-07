App.Campaigns = {
  Index: Backbone.View.extend({
    el: 'body',

    initialize: function(){
      $('#explore_field').chosen().change(function(event){
        location.href = event.target.value;
      });

    }
  
  }),
  Create: Backbone.View.extend({
     el: 'body',

    events: {
      'focus input' : 'showTip',
      'focus textarea' : 'showTipAndExpand',
      'click select, input[type="file"]' : 'showTip',
      'blur input': 'hideTip',
      'blur textarea': 'hideTipAndNormalize'
    },
    
    showTip: function(event) {
      $(event.target).next('span.tip').first().slideDown('fast').css({display: 'block'});
    },
    hideTip: function(event) {
      $(event.target).next('span.tip').first().slideUp(10);
    },

    hideTipAndNormalize: function(event){
      this.hideTip(event);
      $(event.target).animate({height: '80px'});
    },
    showTipAndExpand: function(event) {
      this.showTip(event);
      $(event.target).animate({height: '220px'});
    }
  }),

  Show: Backbone.View.extend({
    el: 'body',

    events: {
      'change form.featured input': 'submitForm',
      'click .show_all_influencers' : 'showInfluencers'
    },

    showInfluencers: function(event){
      $(".targets ol li.hidden").slideDown('slow');
      $(event.target).detach();
    },

    initialize: function(){
      $(".email_text").hide();
      $(".facebook_text").hide();
      $(".twitter_text").hide();

      $(".poke_btn.email").mouseover(function(){ 
        $(".email_text").show(); 
        $("form.email").addClass("selected");
        $(".facebook_text").hide();
        $("form.facebook").removeClass("selected");
        $(".twitter_text").hide();
        $("form.twitter").removeClass("selected");
      });

      $(".poke_btn.facebook").mouseover(function(){
        $(".email_text").hide(); 
        $("form.email").removeClass("selected");
        $(".facebook_text").show();
        $("form.facebook").addClass("selected");
        $(".twitter_text").hide();
        $("form.twitter").removeClass("selected");
      });

      $(".poke_btn.twitter").mouseover(function(){
        $(".email_text").hide(); 
        $("form.email").removeClass("selected");
        $(".facebook_text").hide();
        $("form.facebook").removeClass("selected");
        $(".twitter_text").show();
        $("form.twitter").addClass("selected");
      });

      $(".poke_btn.email").click(function(){ $("form.email").submit(); });
      $(".poke_btn.facebook").click(function(){ $("form.facebook").submit(); });
      $(".poke_btn.twitter").click(function(){ $("form.twitter").submit(); });

      $("a[href='#poke_buttons']").click(function(){ $(".poke_buttons").hide(); $(".poke_buttons").fadeIn(); })
    },

    submitForm: function(event) {
      $(event.target).closest('form').submit();
    }
  })
};


App.Campaigns.New = App.Campaigns.Create.extend();
App.Campaigns.Edit = App.Campaigns.Create.extend();
