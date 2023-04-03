Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :exchanges, only: [:index, :show]
      resources :tickers, only: [:index, :show]
      resources :currencies, only: [:index, :show]
      resources :watch_lists, only: [:index, :show]
      resources :ticker_pairs, only: [:index, :show]
    end
  end
end
