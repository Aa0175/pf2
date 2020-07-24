Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :answers
  resources :questions
  resources :posts

  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions',
                                      passwords: 'users/passwords'}
  root 'posts#index'
  get "users/:id", :to => "users#show", as: "user"
  get "users/", :to => "users#index", as: "users"

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
