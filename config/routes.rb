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
    collection do
      get 'attributes'
      post 'save_attributes'
      get 'search'
      get "personalies"
      get "big_five"
      post "save_personalities"
      post "save_big_five"
      get "favorite"
      post "save_favorite"
    end
  end
    get "users/edit_attributes/:id", :to => "users#edit_attributes", as: :edit_attributes
    patch "users/update_attributes/:id", :to => "users#update_attributes", as: :update_attributes

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
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
