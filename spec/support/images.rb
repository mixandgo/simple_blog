def attach_image(selector, image)
  attach_file(selector, File.expand_path(File.join("spec", "fixtures", "blog_post", image)), :visible => false)
end

