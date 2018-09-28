Rails.application.routes.draw do

  resources :sites
  get 'error' => 'sites#error'

  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
