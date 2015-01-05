Rails.application.routes.draw do
  resources :websites

  resources :publications

  resources :recipes do
    get 'new_publication', on: :collection
    post 'create_publication', on: :collection
  end


  root 'recipes#index'

end
