Rails.application.routes.draw do
  get 'patients/search_form', to: 'patients#search_form', as: 'search_form_patients'
  get 'patients/search', to: 'patients#search', as: 'search_patients'
  get 'patients/calendar', to: 'patients#calendar', as: 'calendar_patients'
  get 'patients/index'
  get 'patients/show'
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users 
  resources :patients, only: [:new, :create, :index, :show, :edit, :update, :destroy, :search] do
    member do
      patch :update_metal_amount
      patch :update_note_checked
      patch :update_delivery_checked
    end
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
