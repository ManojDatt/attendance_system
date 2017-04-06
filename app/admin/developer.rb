ActiveAdmin.register Developer do

	permit_params :email,:username,:domain,:password
	config.batch_actions = false
	actions :all

	action_item :view, only: :show do
		link_to 'Today DSR',  daily_path(developer) , method: :get,:class=>"line_spacing" 
	end

	action_item :view, only: :show do
		link_to 'Monthly DSR', monthly_path(developer) , method: :get,:class=>"line_spacing"
	end


	index download_links: [:csv] do
		# id_column
		column :email
		column :username
		column :domain
		column "Created Date", :created_at
		actions
	end

	filter :email
	filter :username
	filter :domain	

	form do |f|
		f.inputs "Developer" do
			f.input :username
			f.input :email
			f.input :password
			f.input :domain
		end
		f.actions
	end

	show :title => "Developer" do
		attributes_table do 
			row :email
			row :username
			row :domain
			row :sign_in_count
			row :current_sign_in_at
			row :last_sign_in_at
			row :current_sign_in_ip
			row :last_sign_in_ip			
			row :created_at
			row :updated_at
		end
	end 
	controller do

		def monthly
			@monthly_dsr = Developer.find(params[:id]).todos.where("created_at >= ?",Time.zone.now.beginning_of_month)	

		end

		def daily
			@daily_dsr = Developer.find(params[:id]).todos.where("created_at >= ?",Time.zone.now.beginning_of_day)	
		end
	end
end

