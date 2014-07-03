Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get "/blog" => "blog_posts#index", :as => :blog_posts
  get "/blog/:slug" => "blog_posts#show", :as => :blog_post
  get '/blog/tag/:tag' => "blog_posts#filter", :as => :filter_posts

  namespace :admin do
    resources :blog_posts
  end
end
