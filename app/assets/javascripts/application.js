// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require ./lib/underscore.js
//= require ./lib/backbone.js
//= require ./lib/jquery.inputmask.js
//= require ./lib/jquery.inputmask.extensions.js
//= require ./lib/jquery.mask.min
//= require ./lib/modernizr
//= require chosen-jquery
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery.facebox
//= require jquery-infinite-scroll
//= require typeahead.js
//= require autocomplete-rails
//= require meurio_ui
//= require foundation
//= require_tree ./lib
//= require ./app.js
//= require_tree ./app
//= require ./init.js

$(function(){
  $("input.phone").mask('(00) 000000000');

  // TODO: separar o Typeahead do application.js
  var bestPictures = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    // TODO: buscar a url a partir de um atributo data
    remote: 'http://localhost:3000/influencers/search?q=%QUERY'
  });

  bestPictures.initialize();

  $('.typeahead').typeahead({
    minLength: 1,
    highlight: true,
  }, {
    name: 'id',
    displayKey: 'content',
    source: bestPictures.ttAdapter()
  });

  $('.typeahead').bind("typeahead:selected", function(event, object, dataset){
    console.log(object);
    $("#targets").append(
      "<div class='target'>" +
      "<div class='target-name'>" +
      object.searchable.name +
      "</div>" +
      "<div class='target-role'>" +
      object.searchable.role +
      "</div>" +
      "</div>"
    );
  });

  Foundation.libs.abide.settings.patterns.email = /([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z\_\-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}/;
  $(document).foundation();

  // campaigns#show
  $('.show_all_influencers').click(function(e){ $('.targets .user_thumb').slideDown(); $(e.target).remove(); });

  // campaigns#new campaigns#edit
  $('#campaign_poke_type').change(function(e){
    $('.email_text').hide();
    $('.facebook_text').hide();
    $('.twitter_text').hide();
    $('.' + $(e.target).val() + '_text').show();
  });
  $('#campaign_poke_type').trigger('change');
});
