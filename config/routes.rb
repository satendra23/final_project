Rails.application.routes.draw do
  # get 'list', to:"article#index"
  # get 'article/:id' , to: "article#show"
  # post 'article/new', to: "article#create"
  # get 'article/:id', to: "article#edit"
  # patch 'article/:id', to "article#update"
  # delete '/article/:id', to: 'article#destroy'
  
  

  # get 'category/list', to: "category#index"
  # get  '/category', to: "category#find"

  # get '/user/:id', to:"user#show"
  post '/article/create', to: 'article#create'
  get '/article/show/:id', to: 'article#show'
  delete '/article/delete/:id', to: 'article#delete'
  get '/article', to: 'article#index'
  put 'article/update', to: 'article#update'
  delete 'article/delete/:id', to: 'article#delete'


  get '/category/create', to: 'category#create'
  get '/category', to: 'category#show'
  get '/category/delete/:id', to: 'category#delete'
  get '/find',to: 'article#category'

  # get '/login', to: 'sessions#new'
  # post '/sessions', to: 'sessions#create'
  # delete '/sessions', to: 'sessions#destroy'
  get '/user/show', to: 'user#show'
  get '/user/signup', to: 'user#new'
  post '/user/create', to: 'user#create'
  get '/user/:id', to: 'user#find'
  put '/user/edit/:id', to: 'user#edit'
  delete '/user/delete/:id', to: 'user#delete'
  put '/user/edit', to: 'user#edit'
  get '/user', to: 'user#find'
  get '/user/article', to: 'user#authart'

  post 'user/login', to: 'authentication#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
