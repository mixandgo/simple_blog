FactoryGirl.define do
  factory :blog_post do
    sequence(:title) {|n| "Awesome post title #{n}" }
    body "Even more awesome post body"
    published_at 1.week.ago
  end
end
