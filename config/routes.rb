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
  resources :rooms do
    collection do
      get 'search'
    end
  end
  resource :session, only: [:create, :destroy]

  namespace :admin do
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
    resources :rooms do
      collection do
        get 'search'
      end
    end
  end
end
