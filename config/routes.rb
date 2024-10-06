Rails.application.routes.draw do
  get 'metal_usages/new'
  get 'metal_usages/create'
  get 'metals/index'
  get 'metals/new'
  get 'metals/create'
  get 'metals/edit'
  get 'metals/update'
  get 'metals/show'
  get 'supplies/index'
  get 'messages/create'
  get 'chat_rooms/index'
  get 'patients/search_form', to: 'patients#search_form', as: 'search_form_patients'
  get 'patients/search', to: 'patients#search', as: 'search_patients'
  get 'patients/calendar', to: 'patients#calendar', as: 'calendar_patients'
  get 'patients/index'
  get 'patients/show'
  get 'shipments', to: 'shipments#index', as: 'shipments'
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users 
  resources :patients, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    collection do
      get :archives
      post :archive
      get 'show_archive/:year', to: 'patients#show_archive', as: :show_archive
    end
    member do
      patch :update_metal_amount
      patch :update_note_checked
      patch :update_delivery_checked
    end
  end

  resources :patient_archives, only: [:show], path: 'archives/details'

  resources :models do
    patch 'update_storage_location', on: :member
  end
  
  resources :chat_rooms, only: [:index, :show] do
    resources :messages, only: [:create] do
      post 'favorite', on: :member
    end
  end

  resources :prostheses, only: [:index, :show] do
    collection do
      get 'list', to: 'prostheses#list'
    end
  end

  resources :metals do
    resources :metal_purchases, only: [:edit, :update, :destroy]
    resources :metal_usages, only: [:new, :create, :destroy]
    member do
      get 'new_purchase'
      post 'create_purchase'
    end
  end

  resources :supplies, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      patch :update_quantity
      patch :mark_delivered
      get :show_archive
    end

    collection do
      post :archive
      get :archives
    end
  end
  resources :orders do
    patch :mark_delivered, on: :member
  end
  
  root 'home#index'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get  '/password/edit', to: 'users#edit_password', as: 'edit_password'
  patch '/password/update', to: 'users#update_password', as: 'update_password'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
