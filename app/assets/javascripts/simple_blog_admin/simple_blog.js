$(document).ready(function() {
  addCkeditor('simple-blog-post-form-body');
  addCkeditor('simple-blog-post-form-description');
  setAutocomplete('simple-blog-post-form-tag-list');
  setTitleValidation();
});

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
      $.getJSON("/admin/blog_posts/get_tags", {
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

  $(".edit_blog_post").on("keyup", "#blog_post_title", function(event) {
    if ($("#blog_post_title").val().length > 65) {
      if ($("#simple-blog-form-errors").length > 0) {
        $("#simple-blog-form-errors").html(warningMessage);
      } else {
        $("#blog_post_title").after("<div id='simple-blog-form-errors' class=''>" + warningMessage + "</div>")
      }
    } else {
      $("#simple-blog-form-errors").html("");
    }
  })

}
