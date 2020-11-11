Rails.application.routes.draw do
  root 'results#new'
  resources :results, except: [:index]
  get 'rankings(/:category)', to: 'rankings#index', as: 'ranking'
end
