# frozen_string_literal: true
require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users

  resources :currencies
  resources :exchanges
  resources :ticker_pairs
  resources :tickers

  mount Sidekiq::Web => '/sidekiq'
end
