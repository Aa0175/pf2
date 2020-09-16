Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :posts do
    get :search, on: :collection
    get :favorite_index
    post :create_favorite
  end

  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions',
                                      passwords: 'users/passwords'}

  root 'posts#index'
  # root to: 'home#index'

  resources :users do
    get "personalities", :to => "users#personalities"
    get "big_five", :to => "users#big_five"
    post "personalities/:id", :to => "users#personalities_create"
    post "big_five/:id", :to => "users#big_five_create"
    get "favorite", :to => "users#favorite_users"
    post "favorite:id", :to => "users#favorite_create"
    get :search, on: :collection
    get :attributes, on: :collection
  end

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
