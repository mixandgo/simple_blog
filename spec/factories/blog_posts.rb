FactoryGirl.define do
  factory :blog_post do
    sequence(:title) {|n| "Awesome post title #{n}" }
    body "Even more awesome post body"
    description "The most awesome post description"
    keywords "awesome, marketing, simple_blog, post"
    published_at 1.week.ago

    trait :empty_post do
      title ""
      body ""
      description ""
      keywords ""
      published_at nil
    end
  end
end
