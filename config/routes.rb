Rails.application.routes.draw do  
  devise_for :admins, skip: :registrations
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :attendances, only:[:index,:create]
  resources :projects
  resources :todos,only:[:new,:create]
  devise_for :developers, skip: :registrations
  root "attendances#index"
  get "punch_out"=>"attendances#punch_out", as: :punch_out
end
