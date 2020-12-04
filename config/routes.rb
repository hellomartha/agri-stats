Rails.application.routes.draw do
  root 'top#show'

  resources :results, except: [:index]
  resources :cards, only: [:show]

  get 'rankings(/:category)', to: 'rankings#index', as: 'ranking'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/mypage', to: 'users#show', as: "mypage"
end
