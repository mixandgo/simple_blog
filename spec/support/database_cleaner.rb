DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
    FileUtils.rm_rf('spec/dummy/public/uploads/ckeditor/pictures')
  end
end
