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
      if($.trim(this.previewData.html()) == ''){
        var matches = this.oldValue.match(/http:\S*/);
        if(matches && matches.length > 0){
          this.preview.find('.loader').show();
          this.previewData.hide();
          this.preview.find('.remove_preview').hide();
          this.root.data('url', matches[0]);
          $.get('http://api.embed.ly/1/oembed?url=' + encodeURIComponent(matches[0]))
          .complete(this.onEmbedlyComplete)
          .success(this.onEmbedlySuccess);
        }
      }
    },

    onEmbedlyComplete: function(data){
      this.preview.find('.loader').hide();
      this.previewData.show();
    },

    onEmbedlySuccess: function(data){
      data = JSON.parse(data);
      this.previewData.html('');
      this.previewData
      .append($('<div>').addClass('image').append($('<img>').addClass('thumbnail').attr('src', data.thumbnail_url)))
      .append($('<div>').addClass('title_and_description')
        .append($('<a>').addClass('title').attr('href', data.url).attr('target', '_blank').html(data.title))
        .append($('<div>').addClass('description').html(data.description))
      );
      this.preview.find('.remove_preview').show();
    },

    initialize: function(options){
      _.bindAll(this);
      this.preview = options.preview;
      this.previewData = this.preview.find('.preview_data');
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
      'ajax:before' : 'onBefore',
      'ajax:success' : 'onAjaxSuccess',
      'click .remove_preview' : 'removePreview'
    },

    removePreview: function(event){
      this.previewData.html('');
      $(event.target).hide();
      return false;
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

    onBefore: function(){
      this.$('.inline-errors').remove();
      this.$('.loader').show();
      var post = this.$('textarea#post_content');
      post.val(
        post.val().replace(post.data('url'), '') + '<br/>' + this.previewData.html()
      );
    },

    initialize: function(options){
      this.posts = options.posts;
      this.previewData = this.$('.preview_data');
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
      this.preview = this.$('.preview');
      this.postForm = new App.Campaigns.Post({posts: this.posts});
      this.postContent = new App.Campaigns.PostContent({preview: this.preview}); 
      this.fbPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='email'])"});
      this.twPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='twitter'])"});
      this.emPokeForm = new App.Campaigns.Poke({el: "form:has(input[value='facebook'])"});
      $.get(this.posts.data('path')).success(function(data){
        that.posts.html(data);
      });
    }
  })
};
