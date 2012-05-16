App.Campaigns = {
  PostContent: Backbone.View.extend({
    el: 'textarea#post_content',

    events: {
      'keyup' : 'onKeyup'
    },

    onKeyup: function(event){
      var value = this.root.val();
      if(this.t){
        window.clearTimeout(this.t);
      }
      if(value != this.oldValue){
        this.oldValue = value;
        this.t = window.setTimeout(this.onTimeout, 1000);
      }
    },

    onTimeout: function(event){
      var matches = this.oldValue.match(/http:\S*/);
      if(matches && matches.length > 0){
        $('.preview .loader').show();
        $.get('http://api.embed.ly/1/oembed?url=' + encodeURIComponent(matches[0])).success(this.onEmbedlySuccess);
      }
    },

    onEmbedlySuccess: function(data){
      $('.preview .loader').hide();
      console.log(data);
    },

    initialize: function(){
      _.bindAll(this);
      this.root = $(this.el);
      this.oldValue = this.root.val();
    }
  }),
  
  Poke: Backbone.View.extend({
    events: {
      'click a' : function(){ this.el.submit(); }
    }
  }),

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
      this.postContent = new App.Campaigns.PostContent(); 
      this.fbPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='email'])"});
      this.twPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='twitter'])"});
      this.emPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='facebook'])"});
      $.get(this.posts.data('path')).success(function(data){
        that.posts.html(data);
      });
    }
  })
};
