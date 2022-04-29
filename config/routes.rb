# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin/pages/dashboard', to: 'admin_users/pages#dashboard'
  get 'dashboard', to: 'pages#dashboard'
  
  namespace :admin_users do
    root to: 'pages#dashboard'
    resources :employees
  end

  devise_for :admin_users, path: "admin", controllers: {
    sessions: "admin_users/sessions"
  }
  devise_for :employees, path: "employee", controllers: {
    sessions: "employees/sessions",
    registrations: "employees/registrations"
  }

  resources :kudos
  
  root to: "kudos#index"
end
