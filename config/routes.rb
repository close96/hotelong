Rails.application.routes.draw do
  root "top#index"
  resources :members do
    collection do
      post 'confirm'
    end
  end
  resources :mypage
  resources :plans
  resources :reservations do
    collection do
      post 'confirm'
    end
  end
  resources :rooms
  resource :session, only: [:create, :destroy]
end
