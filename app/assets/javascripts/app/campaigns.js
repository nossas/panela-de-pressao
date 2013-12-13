App.Campaigns = {
  Index: Backbone.View.extend({
    el: 'body',

    initialize: function(){
      $('#explore_field').chosen().change(function(event){
        location.href = event.target.value;
      });

    }
  
  }),

  Show: Backbone.View.extend({
    initialize: function(){
      $(document.location.hash + "_btn").click();
    }
  })
};
