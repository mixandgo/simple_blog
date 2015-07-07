function setKeywordHandler() {
  $(".js-simple-blog-form").on("blur", ".js-simple-blog-keyword-parser", function(event){
    KeywordParser.showTopKeywords($(this).val());
  })
}

function addDatepicker() {
  $(".js-simple-blog-published-at").datepicker({ dateFormat: "dd/mm/yy" });
}

function setAutocomplete(elementId) {
  $("."+elementId).on("keydown", function(event) {
    if (event.keyCode === $.ui.keyCode.TAB && $(this).autocomplete("instance").menu.active) {
      event.preventDefault();
    }
  }).autocomplete({
    source: function(request, response) {
      $.getJSON('/admin/blog_posts/get_tags', {
        term: extractLast(request.term)
      }, response);
    },
    messages: {
      // removed the helper message that autocomplete shows by default
      noResults: '',
      results: function() {}
    },
    search: function() {
      // custom minLength
      var term = extractLast(this.value);
      if (term.length < 2) {
        return false;
      }
    },
    focus: function() {
      // prevent value inserted on focus
      return false;
    },
    select: function(event, ui) {
      var terms = split(this.value);
      // remove the current input
      terms.pop();
      // add the selected item
      terms.push(ui.item.value);
      // add placeholder to get the comma-and-space at the end
      terms.push("");
      this.value = terms.join(", ");

      return false;
    }
  });
}

function split(val) {
  return val.split(/,\s*/);
}

function extractLast(term) {
  return split(term).pop();
}

function setTitleValidation() {
  var warningMessage = "Warning: Blog post title has over 65 characters."

  $(".js-simple-blog-form").on("keyup", ".js-simple-blog-title", function(event) {
    if ($(this).val().length > 65) {
      // add the warning message
      $(".js-simple-blog-title-warning").html(warningMessage);
    } else {
      // remove the warning message if title is below 65 characters so it doesn't show a warning when it's not needed
      $(".js-simple-blog-title-warning").html("");
    }
  })
}

function setLinkHandler() {
  $(".js-link-creator").on("click", ".js-new-link", function(event) {
    event.preventDefault();
    var defaultLink = $(this).data("link");
    var linkCreator = $(this).closest(".js-link-creator");
    var source = linkCreator.find(".js-custom-source").val();
    var medium = linkCreator.find(".js-custom-medium").val();
    defaultLink = defaultLink.replace("---Source---", source);
    defaultLink = defaultLink.replace("---Medium---", medium);
    linkCreator.find(".js-custom-link").val(defaultLink);
  })
}

$(document).ready(function() {
  setAutocomplete('js-simple-blog-tag-list');
  setAutocomplete('js-simple-blog-keyword-list');
  setTitleValidation();
  addDatepicker();
  setLinkHandler();
});
