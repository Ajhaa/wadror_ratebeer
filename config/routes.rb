Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_closed', on: :member
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'clubs', to: 'beer_clubs#index'
  get 'places', to: 'places#index'
  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'



  resources :styles

  resource :session, only: [:new, :create, :destroy]

  resources :ratings, only: [:index, :new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
