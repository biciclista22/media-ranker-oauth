Rails.application.routes.draw do
  root 'works#root'

  post '/logout', to: 'sessions#logout', as: 'logout'

  resources :works
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote'

  resources :users, only: [:index, :show]

  get "/auth/:provider/callback", to: "sessions#login"
  #make : to provider -- creating a params
  #this is not a RESTful route

  # get '/login', to: 'sessions#login_form', as: 'login'
  # post '/login', to: 'sessions#login'


end
