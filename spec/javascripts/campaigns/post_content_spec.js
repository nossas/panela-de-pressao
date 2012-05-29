describe("Campaigns.PostContent", function(){
  var view;
  var el = $('<textarea>test content</textarea>');
  var preview = $('<preview>').append($('<div>').addClass('preview_data'));

  beforeEach(function(){
    view = new App.Campaigns.PostContent({preview: preview, el: el[0]});
  });

  describe("#initialize", function(){
    it("should copy options preview to view.preview", function(){
      expect(view.preview).toEqual(preview);
    });

    it("should copy root el value to view.oldValue", function(){
      expect(view.oldValue).toEqual(el.val());
    });
  });

  describe("#onKeyup", function(){
    beforeEach(function(){
      view.t = 1;
      spyOn(window, "clearTimeout");
      spyOn(window, "setTimeout").andReturn(2);
      view.onKeyup();
    });

    it("should clear timeout if there is already one", function(){
      expect(window.clearTimeout).toHaveBeenCalledWith(1);
    });

    describe("when value has not changed", function(){
      it("should not set a new timeout", function(){
        expect(view.t).toEqual(1);
      });
    });

    describe("when value has changed", function(){
      beforeEach(function(){
        view.root.val('changed value');
        view.onKeyup();
      });

      it("should set a new timeout", function(){
        expect(view.t).toEqual(2);
      });

      it("should copy current root val to oldValue", function(){
        expect(view.oldValue).toEqual(el.val());
      });
    });
  });

  describe("#onTimeout", function(){
    var successCallback = jasmine.createSpy('success');
    var completeCallback = jasmine.createSpy('complete');
    beforeEach(function(){
      view.previewData.html('');
      view.oldValue = 'http://www.foo.bar';
      spyOn(view.loader, "show");
      spyOn(view.previewData, "hide");
      spyOn(view.removePreview, "hide");
      completeCallback.andReturn({success: successCallback})
      spyOn($, "get").andReturn({complete: completeCallback});
      view.onTimeout();
    });

    it("should show the loader", function(){
      expect(view.loader.show).toHaveBeenCalled();
    });

    it("should hide the previewData", function(){
      expect(view.previewData.hide).toHaveBeenCalled();
    });

    it("should hide the removePreview", function(){
      expect(view.removePreview.hide).toHaveBeenCalled();
    });

    it("should store the matched URL in root data", function(){
      expect(view.root.data('url')).toEqual(view.oldValue);
    });

    it("should call get passing and encoded url and setting the callbacks", function(){
      expect($.get).toHaveBeenCalledWith('http://api.embed.ly/1/oembed?url=' + encodeURIComponent(view.oldValue));
      expect(completeCallback).toHaveBeenCalledWith(view.onEmbedlyComplete);
      expect(successCallback).toHaveBeenCalledWith(view.onEmbedlySuccess);
    });
  });

  describe("#onEmbedlyComplete", function(){
    beforeEach(function(){
      spyOn(view.loader, "hide");
      spyOn(view.previewData, "show");
      view.onEmbedlyComplete();
    });

    it("should hide the loader", function(){
      expect(view.loader.hide).toHaveBeenCalled();
    });

    it("should show the previewData", function(){
      expect(view.previewData.show).toHaveBeenCalled();
    });
  });

  describe("#onEmbedlySuccess", function(){
    describe("with html", function(){
      var data = {
        thumbnail_url: 'http://thumbnail.com',
        html: '<iframe></iframe>',
        url: 'http://url.com',
        title: 'test title',
        description: 'test description'
      };
      var fakeEmbedlyData = JSON.stringify(data);

      beforeEach(function(){
        spyOn(view.previewData, "html").andCallThrough();
        spyOn(view.removePreview, "show");
        view.onEmbedlySuccess(fakeEmbedlyData);
      });

      it("should copy embedly data to previewData", function(){
        expect(view.previewData.find('.image img').length).toEqual(0);
        expect(view.previewData.find('.image iframe').length).toEqual(1);
        expect(view.previewData.find('.title_and_description a.title').attr('href')).toEqual(data.url);
        expect(view.previewData.find('.title_and_description a.title').html()).toEqual(data.title);
        expect(view.previewData.find('.title_and_description .description').html()).toEqual(data.description);
      });
    });

    describe("without html", function(){
      var data = {
        thumbnail_url: 'http://thumbnail.com',
        url: 'http://url.com',
        title: 'test title',
        description: 'test description'
      };
      var fakeEmbedlyData = JSON.stringify(data);

      beforeEach(function(){
        spyOn(view.previewData, "html").andCallThrough();
        spyOn(view.removePreview, "show");
        view.onEmbedlySuccess(fakeEmbedlyData);
      });


      it("should clear the previewData", function(){
        expect(view.previewData.html).toHaveBeenCalledWith('');
      });

      it("should copy embedly data to previewData", function(){
        expect(view.previewData.find('.image img').attr('src')).toEqual(data.thumbnail_url);
        expect(view.previewData.find('.title_and_description a.title').attr('href')).toEqual(data.url);
        expect(view.previewData.find('.title_and_description a.title').html()).toEqual(data.title);
        expect(view.previewData.find('.title_and_description .description').html()).toEqual(data.description);
      });

      it("should show removePreview", function(){
        expect(view.removePreview.show).toHaveBeenCalled();
      });
    });

  });
});
