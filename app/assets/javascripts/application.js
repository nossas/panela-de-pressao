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
  var influencers = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    // TODO: buscar a url a partir de um atributo data
    remote: $("#influencers-autocomplete .typeahead").data("search-url") + '?q=%QUERY'
  });

  influencers.initialize();

  $('#influencers-autocomplete .typeahead').typeahead({
    minLength: 1,
    highlight: true
  }, {
    name: 'id',
    displayKey: 'content',
    source: influencers.ttAdapter(),
    templates: {
      suggestion: function(data){
        return "<div>" +
          "<span class='name'>" + data.searchable.name + "</span>, " +
          "<span class='role'>" + data.searchable.role + "</span></div>";
      }
    }
  });

  $('.typeahead').keydown(function(e) { 
    if(e.which == 13) e.preventDefault();
  }); 

  $('.typeahead').bind("typeahead:selected", function(event, object, dataset){
    if($(".influencer-field[data-influencer-id = " + object.searchable.id + "]").size() == 0){
      $("#influencers-list").append(object.searchable.html);
      addEventListenerToRemoveTargetLink();
    }
  });

  function addEventListenerToRemoveTargetLink(){
    $(".influencer-field .influencer-field-remove a").click(function(event){
      $(event.target).parent().parent().remove();
      return false;
    });
  }

  addEventListenerToRemoveTargetLink();

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
