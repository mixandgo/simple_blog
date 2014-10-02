def attach_image(image)
  attach_file("file", File.expand_path(File.join("spec", "fixtures", "blog_post", image)), :visible => false)
end

