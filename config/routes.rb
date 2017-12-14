Rails.application.routes.draw do
  root "top#index"
  resources :members
  resources :mypage
  resources :plans
  resources :reservations
  resources :rooms
end