App.Campaigns = {
  Post: Backbone.View.extend({
    el: 'form.new_post',
    events: {
      'ajax:beforeSend' : 'onBeforeSend',
      'ajax:success' : 'onAjaxSuccess'
    },
    
    onAjaxSuccess: function(event, data){
      var form = $(this.el);
      this.posts.html(data);
      this.el.reset();
      this.$('.loader').hide();
      var errors = this.posts.find('ul').data('errors');
      if(errors){
        $.each(errors, function(key, val){
          var message = val.join(", ");
          form.append($('<div>').addClass('inline-errors').html(message));
        });
      }
    },

    onBeforeSend: function(){
      this.$('.inline-errors').remove();
      this.$('.loader').show();
    },

    initialize: function(options){
      this.posts = options.posts;
    }
  }),

  Show: Backbone.View.extend({
    el: 'body',

    events: {
      'ajax:beforeSend .remove-post' : 'showLoader',
      'ajax:success .remove-post' : 'onAjaxSuccess'
    },

    onAjaxSuccess: function(event, data){
      this.posts.html(data);
      $(event.target).next('.loader').show();
    },

    showLoader: function(event, data){
      $(event.target).next('.loader').show();
    },

    initialize: function(){
      var that = this;
      this.posts = this.$('.posts');
      this.postForm = new App.Campaigns.Post({posts: this.posts});
      $.get(this.posts.data('path')).success(function(data){
        that.posts.html(data);
      });
    }
  })
};
