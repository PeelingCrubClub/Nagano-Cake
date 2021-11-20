Rails.application.routes.draw do
  
  #管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
  }
  
  namespace :admin do
   get 'admin/new', to: 'admin/sessions#new'
  
  #items
  resouces :items, only:[:new, :show, :index, :edit, :create, :update]  
  
  #genres
  resouces :genres, only:[:index, :edit, :create, :update] 
  
  #customers
  resouces :customers, only:[:index, :edit, :show, :update]
  
  #orders
  resouces :orders, only:[:show, :update]
  
  #oder_items
  resouces :oder_items, only:[:update]
  
  end
  
    
  #会員
  devise_for :customers, controllers:{
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
  }
  
  scope module: :public do
  
  #homes
  root to: 'homes#top'
  get 'homes#about'
  
  #items
  resouces :items, only:[:show, :index]
  
  #cart_items
  resouces :cart_items, only:[:index, :create, :update, :destroy] do
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  end
   
  #orders
   resouces :orders, only:[:new, :show, :index, :create] do
   post 'orders/confirm' => 'orders#confirm'
   get 'orders/complete' => 'orders#complete'
   end
   
  #customers
   resouces :customers, only:[:show, :edit, :update] do
   get 'customers/leave' => 'customers#leave'
   patch 'customers/out' => 'customers#out'
   end
  
  #deliveries
  resouces :deliveries, only:[:index, :create, :edit, :update, :destroy]  
  
    
  end

 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
