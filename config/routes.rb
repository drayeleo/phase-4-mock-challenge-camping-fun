Rails.application.routes.draw do
  resources :campers, only: %i[index show create]
  resources :signups, only: %i[create]
  resources :activities, only: %i[index destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
