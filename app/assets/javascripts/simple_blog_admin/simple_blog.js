$(document).ready(function() {
  addCkeditor('simple-blog-post-form-body');
  addCkeditor('simple-blog-post-form-description');
  setAutocomplete('simple-blog-post-form-tag-list');
  setAutocomplete('simple-blog-post-form-keyword-list');
  setTitleValidation();
  addDatepicker();
});

function addDatepicker() {
  $("#simple-blog-post-form-published-at").datepicker({ dateFormat: "dd/mm/yy" });
}


function addCkeditor(elementId) {
  if ($("#"+elementId).length) {
    CKEDITOR.replace(elementId, {
      toolbar: [
        { name: 'document', items: [ 'Source' ] },
        { name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline' ] },
        { name: 'insert', items: [ 'Image' ] },
        { name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
      ]
    });
  }
}

function setAutocomplete(elementId) {
  $("#"+elementId).on("keydown", function(event) {
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

  $(".simple-blog-posts-new").on("keyup", "#simple-blog-post-form-title", function(event) {
    if ($(this).val().length > 65) {
      // add the warning message
      $("#simple-blog-form-title-warning").html(warningMessage);
    } else {
      // remove the warning message if title is below 65 characters so it doesn't show a warning when it's not needed
      $("#simple-blog-form-title-warning").html("");
    }
  })

}
