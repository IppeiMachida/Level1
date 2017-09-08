Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  root 'posts#new'

  devise_for :users
  resources :users, only: [:index, :edit, :update, :show] do
    resource :relationships, only: [:create, :destroy] do
      post :accept, on: :member
    end
    get :favorites, on: :member
    get :follows, on: :member
    get :followers, on: :member
    get :requests, on: :member
  end

  root 'users#index'

  resources :posts do
        resource :favorites, only: [:create, :destroy]
        resource :comments, only: [:create, :destroy]
  end
 
  post '/posts' => 'posts#create'
  get '/posts' => 'posts#index'

  # get '/posts/:id' => 'posts#show', as: 'post'

  # get '/posts/:id/edit' => 'posts#edit', as: 'edit_post'
  patch '/posts/:id' => 'posts#update', as: 'update_post'
  delete '/posts/:id/' => 'posts#destroy', as: 'destroy_post'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
