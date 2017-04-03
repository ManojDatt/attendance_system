Rails.application.routes.draw do  
  devise_for :admins, skip: :registrations
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :attendances, only:[:index,:create]
  devise_for :developers, skip: :registrations
  root "attendances#index"
  get "punch_out"=>"attendances#punch_out", as: :punch_out
  get 'developer-profile'=> "attendances#get_developer_profile" , as: :get_developer_profile
end
