Rails.application.routes.draw do
  get 'home/site_index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#site_index'
end
