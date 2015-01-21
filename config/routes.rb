Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :sessions], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :websites

  resources :publications

  resources :recipes do
    get 'new_publication', on: :collection
    post 'create_publication', on: :collection
  end


  root 'recipes#index'

end
