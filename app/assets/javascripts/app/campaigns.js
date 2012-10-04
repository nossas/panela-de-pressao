App.Campaigns = {
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

    events: {
      'change form.featured input': 'submitForm'
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
