Rails.application.routes.draw do

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }

  devise_for :user,
    path: 'public',
    controllers: {
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }

  root :to => "public/homes#top"
  get '/admin' => 'admin/homes#top', as: 'admin'
  get '/about' => 'public/homes#about', as: 'about'

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :movies, only: [:index, :show, :destroy]
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    resources :comments, only: [:destroy]
  end

  namespace :public do
    resources :movies, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
    resources :comments, only: [:create, :destroy]

  end
    resource :users,only: []
    get '/my_page' => 'users#show'
    get '/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/unsubscribe'
    patch 'users/withdraw'
  end





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
