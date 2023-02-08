Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get "home/about"=>"homes#about" ,as: 'about'
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  delete 'books/:id' => 'books#destroy'
  end
  resources :users, only: [:index, :show, :edit, :update]
end