App.Campaigns = {
  Index: Backbone.View.extend({
    el: 'body',

    initialize: function(){
      $('#explore_field').chosen().change(function(event){
        location.href = event.target.value;
      });
    }
  }),

  Explore: Backbone.View.extend({
    initialize: function(){
      $('#load_more_campaigns_button').on('click', function() {
        $('#load_more_campaigns_button').hide();
        $('.campaigns-load-more .loader').show();
      });

      $('#filter_form').on('change', function() {
        $('#campaigns-loader').show();
        $('#filter_form').submit();
      });
    }
  }),

  Show: Backbone.View.extend({
    initialize: function(){
      $(document.location.hash + "_btn").click();
    }
  })
};
