Rails.application.routes.draw do
  root "rooms#index"
  resources :rooms, only: [ :index, :show, :new, :create ]
  resources :reservations, only: [ :new, :create, :edit, :update ]
end
