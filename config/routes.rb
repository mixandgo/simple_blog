Rails.application.routes.draw do
  get "/blog" => "blog_posts#index", :as => :blog_posts
  get "/blog/:slug" => "blog_posts#show", :as => :blog_post
  get '/blog/tag/:tag' => "blog_posts#filter", :as => :filter_posts

  namespace :admin do
    resources :blog_posts do
      get "/get_tags" => "blog_posts#get_tags", as: :get_tags, on: :collection
      delete "/delete_blog_image/:blog_image_id" => "blog_posts#delete_blog_image", as: :delete_blog_image, on: :member
    end
  end
end
