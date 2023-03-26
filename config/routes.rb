# frozen_string_literal: true

Rails.application.routes.draw do
  resources :ticker_pairs
  resources :currencies

  ActiveAdmin.routes(self)
  resources :tickers
  resources :exchanges
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "dashboard#index"
end
