Magazine::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  
  resources :categories
  resources :articles
  resources :comments, only: [:index, :create, :destroy]

  get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment

  root :to => "articles#index"
end