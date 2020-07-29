Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :answers
  resources :questions
  resources :posts

  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions',
                                      passwords: 'users/passwords'}

  # root 'posts#index'
  root to: 'home#index'

  get "users/:id", :to => "users#show", as: "user"
  get "users/", :to => "users#index", as: "users"

  namespace :api, {format: 'json'} do
      namespace :v1 do
        resources :nodes, only: [:index, :show, :create, :update, :destroy]
        resources :posts, only: [:index, :show]
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
