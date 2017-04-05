ActiveAdmin.register Developer do

	permit_params :email,:username,:domain,:password
	config.batch_actions = false
	actions :all

	index download_links: [:csv] do
		id_column
		column :email
		column :username
		column :domain
		column "Created Date", :created_at
		column "Actions" do |f|
			a do                                                         
				link_to 'View', admin_developer_path(f),:class=>"line_spacing"
			end        
			a do                                                         
				link_to 'Edit', edit_admin_developer_path(f), method: :get ,:class=>"line_spacing"
			end
			a do                                                         
				link_to 'Delete', admin_developer_path(f), method: :delete, :data => { :confirm => 'Are you sure, you want to delete this user?' },:class=>"line_spacing"
			end
			a do                                                         
				link_to 'Today DSR', daily_path(f), method: :get,:class=>"line_spacing"
			end
			a do                                                         
				link_to 'Monthly DSR',monthly_path(f), method: :get,:class=>"line_spacing"
			end
		end
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

