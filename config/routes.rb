Rails.application.routes.draw do
  devise_for :users, skip: [:registrations] 
  as :user do
    get "users/edit" => "devise/registrations#edit", as: "edit_user_registration"
    patch "users" => "devise/registrations#update", as: "user_registration"
  end
  
  root "static_pages#home"
  resources :users, only: [:show]
  resources :courses, only: [:show]
  
  namespace :admin do
    root "subjects#index"

    resources :subjects, expect: [:edit, :update]
  end
end
