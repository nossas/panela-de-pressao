describe("Campaigns.Show", function(){
  var view;
  var el = $('<body><div class="posts"></div><div class="preview"></div></body>');

  beforeEach(function(){
    view = new App.Campaigns.Show({el: el[0]});
  });

  describe("#initialize", function(){
    it("should assings posts", function(){
      expect(view.posts).toEqual(jasmine.any(Object));
    });

    it("should assings preview", function(){
      expect(view.preview).toEqual(jasmine.any(Object));
    });

    it("should assings postForm", function(){
      expect(view.postForm).toEqual(jasmine.any(App.Campaigns.Post));
    });

    it("should assings postContent", function(){
      expect(view.postContent).toEqual(jasmine.any(App.Campaigns.PostContent));
    });

    it("should assings fbPokeForm", function(){
      expect(view.fbPokeForm).toEqual(jasmine.any(App.Campaigns.Poke));
    });

    it("should assings twPokeForm", function(){
      expect(view.twPokeForm).toEqual(jasmine.any(App.Campaigns.Poke));
    });

    it("should assings emPokeForm", function(){
      expect(view.emPokeForm).toEqual(jasmine.any(App.Campaigns.Poke));
    });
  });
});
