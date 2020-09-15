Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :posts

  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions',
                                      passwords: 'users/passwords'}

  root 'posts#index'
  # root to: 'home#index'

  get "users/:id", :to => "users#show", as: "user"
  get "users/", :to => "users#index", as: "users"

  get "users/personalities", :to => "users#personalities"
  get "users/big_five", :to => "users#big_five"
  post "users/personalities/:id", :to => "users#personalities_create"
  post "users/big_five/:id", :to => "users#big_five_create"
  get "users/favorite_users", :to => "users#favorite_users"
  get "posts/favorite_index", :to => "posts#favorite_index"
  post "users/favorite_users/:id", :to => "users#favorite_create"
  post "posts/favorite_index/:id", :to => "posts#favorite_create"
  get "users/search", :to => "users#search"
  get "posts/search", :to => "posts#search"

  namespace :api, {format: 'json'} do
      namespace :v1 do
        resources :nodes, only: [:index, :show, :create, :update, :destroy]
        resources :posts, only: [:index, :show, :create, :update, :destroy]
      end
  end

  resources :nodes do
    get :new_q, on: :collection
    get :new_a, on: :collection
    post :create_q, on: :collection
    post :create_a, on: :collection
  end

  devise_scope :user do
    get '/users/sign_out', :to => 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
