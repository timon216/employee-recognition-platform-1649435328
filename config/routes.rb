# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin/pages/dashboard', to: 'admin_users/pages#dashboard'
  get 'dashboard', to: 'pages#dashboard'
  get 'admin/kudos', to: 'admin_users/kudos#index'
  get 'admin/employees', to: 'admin_users/employees#index'
  get 'admin/company_values', to: 'admin_users/company_values#index'
  get 'admin/rewards', to: 'admin_users/rewards#index'
 
  namespace :admin_users do
    root to: 'pages#dashboard'
    resources :kudos
    resources :employees
    resources :company_values
    resources :rewards
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
