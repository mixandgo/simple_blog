Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get "/blog" => "blog_posts#index", :as => :blog_posts
  get "/blog/:slug" => "blog_posts#show", :as => :blog_post
  get '/blog/tag/:tag' => "blog_posts#filter", :as => :filter_posts

  namespace :admin do
    resources :blog_posts, :param => :slug do
      get "/get_tags" => "blog_posts#get_tags", as: :get_tags, on: :collection
    end
  end
end
