Rails.application.routes.draw do
  resources :websites

  resources :publications

  resources :recipes do
    get 'new_publication', on: :collection
  end


  root 'static_pages#home'

end
