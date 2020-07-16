Rails.application.routes.draw do
  resources :answers
  resources :questions
  namespace :api do
    resources :posts, only: %i(show)
  end
  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions',
                                      passwords: 'users/passwords'}
  root 'posts#index'
  get "users/:id", :to => "users#show", as: "user"
  get "users/", :to => "users#index", as: "users"
  resources :posts

  devise_scope :user do
    get '/users/sign_out', :to => 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
