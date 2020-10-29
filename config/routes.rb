Rails.application.routes.draw do
  root 'results#new'
  resources :results
  get 'rankings(/:category)', to: 'rankings#index', as: 'ranking'
end
