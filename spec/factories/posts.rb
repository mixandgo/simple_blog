FactoryGirl.define do
  factory :post, :class => SimpleBlog::Post do
    title "Awesome post title"
    body "Even more awesome post body"
    published_at 1.week.ago
  end
end
