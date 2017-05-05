Rails.application.routes.draw do  

match "/admin/developers/:id/daily" => 'admin/developers#daily', via: :get, as: "daily"
match "/admin/developers/:id/monthly" => 'admin/developers#monthly', via: :get, as: "monthly"
match "/admin/leave_applications/:id/accept" => 'admin/leave_applications#accept', via: :get, as: "accept"
match "/admin/leave_applications/:id/reject" => 'admin/leave_applications#reject', via: :get, as: "reject"
match "/admin/developers/:id/get_attandence" => 'admin/developers#get_attandence', via: :get, as: "get_attandence"
match "/admin/developers/:id/download_attandence" => 'admin/developers#download_attandence', via: :get, as: "download_attandence"
match "/admin/dsrs/:id/reply_dsr"=> "admin/dsrs#reply_dsr", via: [:get, :post], as: "admin_reply_dsr"

devise_for :admin_users, ActiveAdmin::Devise.config
ActiveAdmin.routes(self)

resources :projects
resources :leaves,only:[:index]
resources :apply_leaves,only:[:new,:create,:index]
match '/todos'=>'todos#index', as: 'todos', via: [:get, :post]
resources :todos,only:[:index,:new,:create,:show] do
	collection do
		get 'today_research'
		post 'submit_research'
		post 'create', as: 'dsr'
	end
	
end
post "todos/:id/reply_dsr"=>"todos#reply_dsr", as: "reply"
resources :attendances, only:[:index]
resources :notification, only:[:index]
devise_for :developers, skip: :registrations
root "attendances#index"
match '/'=> "attendances#index", via: [:get, :post]
get "punch_out"=>"attendances#punch_out", as: :punch_out
get 'developer-profile'=> "attendances#get_developer_profile" , as: :get_developer_profile

# mount ActionCable.server => '/cable'
match '*path' => redirect('/'), via: [:get,:post]

end
