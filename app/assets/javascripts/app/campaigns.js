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
      $('#filter_form').on('change', function() {
        window.history.pushState("", "", "?" + $('#filter_form').serialize());
        $('#filter_form').submit();
      });

      $('#filter_form').on('ajax:complete',function(data, status, xhr){
        $('#campaigns-list').html(status.responseText);
        initializeCampaignsListScroll();
      });

      initializeCampaignsListScroll();

      function initializeCampaignsListScroll(){
        $("#campaigns-list").infinitescroll('destroy');
        $("#campaigns-list").data('infinitescroll', null);
        $("#campaigns-list").infinitescroll({
          navSelector: "nav.pagination",
          nextSelector: "nav.pagination a[rel=next]",
          path: function(page) { return '?page=' + page + "&" + $("#filter_form").serialize(); },
          itemSelector: "li.campaign",
          loading: {
            finishedMsg: null,
            msgText: "Carregando..."
          }
        });
      }
    }
  }),

  Show: Backbone.View.extend({
    initialize: function(){
      $(document.location.hash + "_btn").click();
    }
  })
};
