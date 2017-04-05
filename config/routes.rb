Rails.application.routes.draw do  
match "/admin/developers/:id/daily" => 'admin/developers#daily', via: :get, as: "daily"
match "/admin/developers/:id/monthly" => 'admin/developers#monthly', via: :get, as: "monthly"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
	# devise_for :admins, skip: :registrations
	# mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	resources :projects
	resources :todos,only:[:new,:create] do
		collection do
			get 'today_research'
			post 'submit_research'
		end
	end
	resources :attendances, only:[:index]
	devise_for :developers, skip: :registrations
	root "attendances#index"
	get "punch_out"=>"attendances#punch_out", as: :punch_out
	get 'developer-profile'=> "attendances#get_developer_profile" , as: :get_developer_profile
end
