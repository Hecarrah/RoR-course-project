Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]

  resource :session, only: [:new, :create, :destroy]

  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to:'ratings#new'
  #post 'ratings', to: 'ratings#create'
  post 'beers', to: 'beers#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

