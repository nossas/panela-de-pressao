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
//= require ./lib/prevent-double-submission.js
//= require chosen-jquery
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery.facebox
//= require jquery-infinite-scroll
//= require typeahead.js
//= require autocomplete-rails
//= require foundation
//= require meurio_ui
//= require_tree ./lib
//= require ./app.js
//= require_tree ./app
//= require ./init.js

$(function(){
  var options = {};
  var instM = $('[data-remodal-id=modal]').remodal(options);
  instM.open();

  $("input.phone").mask('(00) 000000000');

  $("[data-prevent-double-submission]").preventDoubleSubmission();

  // TODO: separar o Typeahead do application.js
  var influencers = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: $("#influencers-autocomplete .typeahead").data("search-url") + '?q=%QUERY',
      ajax: {
        beforeSend: function(){
          $("#influencers-autocomplete .tt-hint").addClass("loading");
        },
        complete: function(){
          $("#influencers-autocomplete .tt-hint").removeClass("loading");
        }
      }
    }
  });

  influencers.initialize();

  $('#influencers-autocomplete .typeahead').typeahead({
    hint: true,
    minLength: 1,
    highlight: true
  }, {
    name: 'searchable_id',
    displayKey: 'content',
    source: influencers.ttAdapter(),
    templates: {
      empty: '<div class="empty-message">Nenhum resultado encontrado</div>',
      suggestion: function(data){
        if(data.searchable_type == "Influencer"){
          return "<div>" +
            "<span class='name'>" + data.searchable.name + "</span>, " +
            "<span class='role'>" + data.searchable.role + "</span></div>";
        } else if(data.searchable_type == "InfluencersGroup"){
          return "<div>" +
            "<span class='name'>" + data.searchable.name + "</span>";
        }
      }
    }
  });

  $('.typeahead').keydown(function(e) {
    if(e.which == 13) e.preventDefault();
  });

  $('.typeahead').bind("typeahead:selected", function(event, object, dataset){
    if($(".influencer-field[data-influencer-id = " + object.searchable.id + "]").size() == 0){
      $("#influencers-list").prepend(object.searchable.html);

      validateInfluencers();
      addEventListenerToRemoveTargetLink();
    }
    $('#influencers-autocomplete .typeahead').typeahead('val', '');
  });

  $('#campaign_poke_type').on('change', function() {
    $('#influencers-poke-error').text($(this).find(':selected').data('error-message'));
    validateInfluencers();
  });

  function validateInfluencers() {
    if ($("#influencers-list").size() == 0) return;

    var invalidTargets = 0;
    $("#influencers-list").children().each(function(index, element) {
      if(jQuery.inArray($("#campaign_poke_type").val(), $(element).data("poke-types")) == -1) {
        $(element).addClass("invalid");
        invalidTargets++;
      } else {
        $(element).removeClass("invalid");
      }
    });

    if(invalidTargets == 0) {
      $("#influencers-poke-error").css("display", "none");
    } else {
      $("#influencers-poke-error").css("display", "inline-block");
    }
  }

  function addEventListenerToRemoveTargetLink(){
    $(".influencer-field .influencer-field-remove a").click(function(event){
      $(event.target).parent().parent().remove();
      return false;
    });
  }

  addEventListenerToRemoveTargetLink();

  // Foundation init
  $(document).foundation({
    abide: {
      patterns: {
        email: /^([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z\_\-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}$/,
        facebook_page: /(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?/
      },
      validators: {
        influencersList: function(el, required, parent){
          if($("#influencers-list").find(".influencer-field").size() > 0){
            // Typeahead encapsulates input and brakes the error message behavior
            $("#twitter-typeahead-error").css("display", "none");
            return true;
          } else {
            $("#twitter-typeahead-error").css("display", "inline-block");
            return false;
          }
        }
      }
    },
    accordion: {
			multi_expand: true
		}
  });

  // Mailcheck
  $('input.mailcheck').on('blur', function() {
    $hint = $(this).siblings('.mailcheck-hint');

    $(this).mailcheck({
      domains: ['globo.com', 'terra.com.br', 'ig.com.br', 'yahoo.com', 'yahoo.com.br'],
      suggested: function(element, suggestion) {
        var message = "Você quis dizer <strong class='suggestion'>" + suggestion.address +
          "@<a href='#'>" + suggestion.domain + "</a></strong>?";
        $hint.html(message).fadeIn(150);
      }, empty: function(element) {
        $hint.hide();
      }
    });
  });

  $('.mailcheck-hint').on('click', function() {
    $email = $(this).siblings('input.mailcheck');
    $email.val($('.mailcheck-hint .suggestion').text());
    $(this).fadeOut(200, function() { $(this).empty(); });
    $email.focus();
    return false;
  });

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
