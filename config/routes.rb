# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admins/pages/dashboard', to: 'admins/pages#dashboard'
 
  namespace :admins do
    root to: 'admins/pages#dashboard'
    resources :kudos
    resources :employees
    resources :company_values
    resources :rewards
  end

  devise_for :admins, path: "admin", controllers: {
    sessions: "admins/sessions"
  }
  devise_for :employees, path: "employee", controllers: {
    sessions: "employees/sessions",
    registrations: "employees/registrations"
  }

  resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[create]
  
  root to: "kudos#index"
end
