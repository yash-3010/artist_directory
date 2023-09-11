# frozen_string_literal: true

Rails.application.routes.draw do
  root 'artists#index'
  get 'requests', to: 'requests#index'
  get 'search', to: 'artists#search', as: 'search'

  resources :comments do
    member do
      put :accept
      delete :reject
    end
  end

  devise_for :users
  resources :categories
  resources :artists do
    resources :comments
    member do
      get :mails
      get :sendmail
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
