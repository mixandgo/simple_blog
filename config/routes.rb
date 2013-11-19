SimpleBlog::Engine.routes.draw do
  root 'posts#index'
  resources :posts, :only => [:index, :create, :new]
  get "*slug" => "posts#show", as:  "post"
end
