Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get '/users', to: 'users#index', as: 'users'
  get '/users/new-post', to: 'posts#new', as: 'new_post'
  post '/users/new-post-create', to: 'posts#create', as: 'create_post'
  get '/users/:id', to: 'users#show', as: "user"
  get '/users/:id/posts', to: 'posts#index', as: "post"
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
  post '/users/new-comment', to: 'comments#create', as: 'create_comment'
  get '/users/:user_id/posts/:post_id/new-comment', to: 'comments#new', as: 'new_comment'
  post '/users/like-post', to: 'likes#create', as: 'create_like'
end
