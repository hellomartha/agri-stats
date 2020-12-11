Rails.application.routes.draw do
  root 'top#show'

  resources :results, except: [:index] do
    get 'exclude_calc', on: :member
    get 'include_calc', on: :member
  end
  resources :cards, only: [:show]

  get 'rankings(/:category)', to: 'rankings#index', as: 'ranking'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/mypage', to: 'users#show', as: "mypage"

  get '/admin/users', to: "admins#users"
  get '/admin/results', to: "admins#results"
end
