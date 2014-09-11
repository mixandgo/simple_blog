Rails.application.routes.draw do
  get "/blog" => "blog_posts#index", :as => :blog_posts
  get "/blog/:slug" => "blog_posts#show", :as => :blog_post
  get '/blog/tag/:tag' => "blog_posts#filter", :as => :filter_posts

  namespace :admin do
    resources :blog_posts do
      get "/get_tags" => "blog_posts#get_tags", as: :get_tags, on: :collection
    end

    namespace :ckeditor do
      get "/blog_post_images/:blog_post_id" => "blog_post_images#index", :as => :blog_post_images
      post "/blog_post_images/:blog_post_id" => "blog_post_images#create", :as => :blog_post_images_create
      delete "/blog_post_images/:blog_post_id/:id" => "blog_post_images#destroy", :as => :blog_post_images_destroy
    end

  end
end
