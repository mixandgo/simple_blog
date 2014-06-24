Rails.application.routes.draw do
  get "/blog" => "blog_posts#index", :as => :blog_posts
  get "/blog/:slug" => "blog_posts#show", :as => :blog_post
  get '/blog/tag/:tag' => "blog_posts#index", :as => :tag

  namespace :admin do
    resources :blog_posts, :param => :slug
  end
end
