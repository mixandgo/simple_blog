$(document).ready(function() {
  // addCkeditor('simple-blog-post-form-body');
  // addCkeditor('simple-blog-post-form-description');
});

function addCkeditor(element_id) {
  if ($("#"+element_id).length) {
    CKEDITOR.replace(element_id, {
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
