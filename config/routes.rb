Rails.application.routes.draw do

  root 'posts#index'

  get 'send_friend_request' => 'friendships#create', as: 'send_friend_request'
  get 'accept_friend_request' => 'friendships#update', as: 'accept_friend_request'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
