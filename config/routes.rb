Rails.application.routes.draw do
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#site_index'
  resources :members, only: [] do
    get :dashboard, on: :member
  end
  resources :albums do
    resources :images
  end
  resources :groups do
    get :add_group_members, on: :member
  end
end
