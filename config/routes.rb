Rails.application.routes.draw do
  get "/blog" => "blog_posts#index", :as => :blog_posts
  get "/blog/:slug" => "blog_posts#show", :as => :blog_post
  get '/blog/tag/:tag' => "blog_posts#filter", :as => :filter_posts

  namespace :admin do
    resources :blog_posts do
      get "/get_tags" => "blog_posts#get_tags", as: :get_tags, on: :collection
    end

    namespace :ckeditor do
      get "/:model_name/:model_id" => "pictures#index", :as => :pictures
      post "/:model_name/:model_id" => "pictures#create", :as => :picture_create
      delete "/:model_name/:model_id/:id" => "pictures#destroy", :as => :picture_destroy
    end
  end
end
