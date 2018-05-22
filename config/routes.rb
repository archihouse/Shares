Rails.application.routes.draw do
  root :to => 'pages#home'

  get '/companies/result' => 'companies#result'

  resources :companies # set up standard CRUD route for companies
  resources :exchanges # set up standard CRUD route for exchanges
  resources :indices # set up standard CRUD route for indices
  resources :industries # set up standard CRUD route for industries
  resources :portfolios # set up standard CRUD route for portfolios

  resources :users, :only => [:new, :create]
  get '/login' => 'session#new'        # Sign in form
  post '/login' => 'session#create'    # Sign in action - Create a new session
  delete '/login' => 'session#destroy' # Sign out
  # See rails guide for routing, in particular nested routes
end
