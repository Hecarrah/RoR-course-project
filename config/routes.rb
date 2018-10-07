Rails.application.routes.draw do
  resources :styles
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]

  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'memberships', to: 'memberships#new'
  delete 'signout', to: 'sessions#destroy'
  delete 'memberships', to: 'memberships#destroy'


  get 'places', to: 'places#index'
  post 'places', to:'places#search'

  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to:'ratings#new'
  #post 'ratings', to: 'ratings#create'
  post 'beers', to: 'beers#create'
  post 'memberships', to: 'memberships#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

