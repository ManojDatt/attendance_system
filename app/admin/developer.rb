ActiveAdmin.register Developer do

	permit_params :email,:username,:domain,:password, :sign_in_mac
	config.batch_actions = false
	actions :all, except:[:destroy]

	action_item :view, only: :show do
		link_to 'Today DSR',  daily_path(developer) , method: :get,:class=>"line_spacing" 
	end

	action_item :view, only: :show do
		link_to 'Monthly DSR', monthly_path(developer) , method: :get,:class=>"line_spacing"
	end

	action_item :view, only: :show do
		link_to 'Attandance in Csv', get_attandence_path(developer) ,:class=>"line_spacing" 
	end


	index download_links: [:csv] do
		# id_column
		column :email
		column :username
		column :domain
		column :sign_in_mac
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
			f.input :password, input_html:{include_blank: false}
			f.input :domain
			f.input :sign_in_mac, as: :string
		end
		f.actions
	end

	show :title => "Developer" do
		attributes_table do 
			row :email
			row :username
			row :domain
			row :sign_in_mac
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
		def get_attandence
			 @months = Date::MONTHNAMES.each_with_index.collect{|m, i| [m, i]}		
		end
		
	end
	member_action :download_attandance,:method=> :post do
		@developer = Developer.find_by(:id=>params[:id])
		@detail = @developer.attendances.where("created_at BETWEEN ? AND ?",params[:from], params[:to_date])
			if @detail.present?
				csv_string = CSV.generate do |csv|
				    # header row
				    csv << %w(id,punch_in_time,punch_out_time,extra_work,work_hour,lat_in,early_out,week_off,punch_in_at,punch_out_at,punch_in_status,first_half,second_half)
				    # add a row for each item
				    @detail.each do |item|
				      csv << [item.id, item.punch_in_time, item.punch_out_time, item.extra_work, item.work_hour, item.lat_in, item.early_out, item.week_off, item.punch_in_at, item.punch_out_at, item.punch_in_status, item.first_half, item.second_half]
				    end
				  end
		 	render :csv => csv_string, :filename => "#{@developer.email}_attandance.csv"
		 else
		 	redirect_to admin_developers_path,:notice=>"Sorry No record found"
		 end
	end
	
end


		 	

