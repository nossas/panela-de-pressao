describe("Campaigns.Post", function(){
  var view;
  var el = $('<form><textarea id="post_content"></textarea><div class="preview_data"><a class="remove_preview"></a></div></form>');
  var posts = $('<div>').addClass('posts');

  beforeEach(function(){
    view = new App.Campaigns.Post({posts: posts, el: el[0]});
  });

  describe("#removePreview", function(){
    beforeEach(function(){
      spyOn(view.previewData, "html");
      spyOn(view.removePreviewLink, "hide");
      view.removePreview();
    });

    it("should clear previewData", function(){
      expect(view.previewData.html).toHaveBeenCalledWith('');
    });

    it("should hide removePreview", function(){
      expect(view.removePreviewLink.hide).toHaveBeenCalled();
    });
  });

  describe("#onAjaxSuccess", function(){
    beforeEach(function(){
      spyOn(view.posts, "html");
      spyOn(view.loader, "hide");
      spyOn(view, "removePreview");
      view.onAjaxSuccess({}, 'test data');
    });

    it("should remove the preview", function(){
      expect(view.removePreview).toHaveBeenCalled();
    });

    it("should load data into posts", function(){
      expect(view.posts.html).toHaveBeenCalledWith('test data');
    });

    it("should hide loader", function(){
      expect(view.loader.hide).toHaveBeenCalled();
    });
  });

  describe("#onBefore", function(){
    beforeEach(function(){
      view.previewData.html('should be appended');
      view.$('textarea#post_content').val('test');
      spyOn(view.loader, "show");
      view.onBefore();
    });

    it("should show loader", function(){
      expect(view.loader.show).toHaveBeenCalled();
    });

    it("should append previewData.html", function(){
      expect(view.$('textarea#post_content').val()).toEqual('test<br/>should be appended');
      view.$('textarea#post_content').val('test');
    });
  });

});

