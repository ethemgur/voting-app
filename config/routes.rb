Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users

  resources :votes

  resources :profiles
  
  root to: 'votes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
