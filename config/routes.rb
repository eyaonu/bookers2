Rails.application.routes.draw do
  get 'books/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  devise_for :users

resources :books, only: [:new, :create, :index, :show]

  get '/top' => 'homes#top'
get "home/about"=>"homes#about", as:'about'
end
