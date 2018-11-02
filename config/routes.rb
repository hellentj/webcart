Rails.application.routes.draw do
  resources :orders do
    member do
      get 'order_details'
    end
  end
  resources :admins do
    member do
      get 'products_all'
      get 'product_details'
      get 'block_user'
      get 'unblock_user'
      get 'new_seller_requests'
      get 'sellers_list'
    end
  end
  resources :quantities
  resources :sizes
  resources :colours
  resources :addresses
  resources :carts
  devise_for :users, controllers: {
        registrations: 'users/registrations', sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users  
  resources :home do
    member do
      get 'check_product'
      get 'after_check_product'
    end
    collection do
      get 'welcome'
    end
  end
  resources :customers do 
    resources :carts
  end
  resources :categories
  resources :images
  resources :sellers do
    resources :products
  end
  root 'home#index'

end
