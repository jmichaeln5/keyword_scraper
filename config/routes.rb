Rails.application.routes.draw do

  root 'pages#home'
  devise_for :users

  resources :sites
  # get '/user/', to: 'users#show', as: 'user'

  resources :users do
    resources :sites
  end

    get 'error' => 'sites#error'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
