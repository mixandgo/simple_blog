module Ckeditor::ApplicationHelper
  def assets_pipeline_enabled?
    return true
  end

  def default_toolbar(form, options)
    {:ckeditor => {
                   :filebrowserImageUploadUrl => admin_ckeditor_blog_post_images_path(form.object.id),
                   :filebrowserImageBrowseUrl => admin_ckeditor_blog_post_images_path(form.object.id),
                   :toolbar => [
                                { name: 'document', items: [ 'Source' ] },
                                { name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
                                { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline' ] },
                                { name: 'insert', items: [ 'Image' ] },
                                { name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
                               ]
                  }
    }.merge(options)
  end
end
