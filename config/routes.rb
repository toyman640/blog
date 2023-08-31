Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: "user"
  get '/users/:id/posts', to: 'posts#index', as: "post"
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'

end
