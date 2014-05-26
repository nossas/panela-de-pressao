var campaignsPage = 0;
function loadCampaigns() {
  campaignsPage++;
  $("a#load_more_campaigns_button").hide();
  $(".campaigns-load-more .loader").show();

  $.get("/explore?page=" + campaignsPage, function(data) {
    $("#campaigns-list").append(data);
    if($("#campaigns-list").data("count") <= $("#campaigns-list .campaign").length)
      $("a#load_more_campaigns_button").remove();

    $("a#load_more_campaigns_button").show();
    $(".campaigns-load-more .loader").hide();
  });
}

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
      loadCampaigns();
      $('a#load_more_campaigns_button').on('click', function(){
        loadCampaigns();
        return false;
      });
    }
  }),

  Show: Backbone.View.extend({
    initialize: function(){
      $(document.location.hash + "_btn").click();
    }
  })
};
