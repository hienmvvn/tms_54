Rails.application.routes.draw do
  devise_for :users, skip: [:registrations] 
  as :user do
    get "users/edit" => "devise/registrations#edit", as: "edit_user_registration"
    patch "users" => "devise/registrations#update", as: "user_registration"
  end
  
  root "static_pages#home"
  
  resources :users, only: [:show]
  resources :user_courses, only: [:show]
  resources :user_subjects, only: [:show, :update]
  resources :user_subjects, only: [:show]
  resources :courses, only: [:show]
  resources :relationships, only: [:create, :destroy]
  
  namespace :admin do
    root "courses#index"

    resources :subjects
    resources :courses
    resources :users, only: [:index, :new, :create]
    resources :course_subjects, only: [:update, :show]
  end
end
