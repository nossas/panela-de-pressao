describe("Campaigns.PostContent", function(){
  var view;
  var preview = $('<preview>').append($('<div>').addClass('preview_data'));

  beforeEach(function(){
    view = new App.Campaigns.PostContent({preview: preview});
  });

  describe("#initialize", function(){
    it("should copy options preview to view.preview", function(){
      expect(view.preview).toEqual(preview);
    });
  });
});
