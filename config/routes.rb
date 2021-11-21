Rails.application.routes.draw do

  #管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: 'admin/sessions',
  }

  namespace :admin do
   get 'admin/new', to: 'admin/sessions#new'

  #items
  resources :items, only:[:new, :show, :index, :edit, :create, :update]

  #genres
  resources :genres, only:[:index, :edit, :create, :update]

  #customers
  resources :customers, only:[:index, :edit, :show, :update]

  #orders
  resources :orders, only:[:index, :show, :update] do
     #oder_items
     resources :order_items, only:[:index, :update]
  end

  end


  #会員
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
  }

  scope module: :public do

  #homes
  root 'homes#top'
  get 'homes/about' => 'homes#about'

  #items
  resources :items, only:[:show, :index]

  #cart_items
  resources :cart_items, only:[:index, :create, :update, :destroy] do
    collection do
      delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    end
  end

  #orders
   resources :orders, only:[:new, :show, :index, :create] do
     collection do
     post 'orders/confirm' => 'orders#confirm'
     get 'orders/complete' => 'orders#complete'
     end
   end

  #customers
   resources :customers, only:[:show, :edit, :update] do
     collection do
     get 'customers/leave' => 'customers#leave'
     patch 'customers/out' => 'customers#out'
     end

   end

  #deliveries
  resources :deliveries, only:[:index, :create, :edit, :update, :destroy]

  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
