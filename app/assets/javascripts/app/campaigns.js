App.Campaigns = {
  Poke: Backbone.View.extend({
    events: {
      'click a' : function(){ this.el.submit(); }
    }
  }),

  Edit: Backbone.View.extend({
    el: 'body',

    events: {
      'click .showmap': 'showMap'
    },

    showMap: function(event){
      event.preventDefault();
      var cur = $(event);
      console.log(cur);
      $('.hidden').fadeToggle();
    }

  }),

  Show: Backbone.View.extend({
    el: 'body',

    initialize: function(){
      this.fbPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='email'])"});
      this.twPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='twitter'])"});
      this.emPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='facebook'])"});
      $(".email_text").hide();
      $(".facebook_text").hide();
      $(".twitter_text").hide();

      $("form.email").mouseover(function(){ 
        $(".email_text").show(); 
        $("form.email").addClass("selected");
        $(".facebook_text").hide();
        $("form.facebook").removeClass("selected");
        $(".twitter_text").hide();
        $("form.twitter").removeClass("selected");
      });

      $("form.facebook").mouseover(function(){
        $(".email_text").hide(); 
        $("form.email").removeClass("selected");
        $(".facebook_text").show();
        $("form.facebook").addClass("selected");
        $(".twitter_text").hide();
        $("form.twitter").removeClass("selected");
      });

      $("form.twitter").mouseover(function(){
        $(".email_text").hide(); 
        $("form.email").removeClass("selected");
        $(".facebook_text").hide();
        $("form.facebook").removeClass("selected");
        $(".twitter_text").show();
        $("form.twitter").addClass("selected");
      });

      $("a[href='#poke_buttons']").click(function(){ $(".poke_buttons").hide(); $(".poke_buttons").fadeIn(); })
    }
  })
};
