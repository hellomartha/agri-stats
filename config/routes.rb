Rails.application.routes.draw do
  root 'results#new'

  resources :results, except: [:index]
  resources :cards, only: [:show]

  get 'rankings(/:category)', to: 'rankings#index', as: 'ranking'
end
