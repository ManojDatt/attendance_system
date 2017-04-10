ActiveAdmin.register ApplyLeave ,as: "Leave Application" do
  scope :Pending
  scope :Approved 
  scope :Rejected 
  scope :Paid 
  scope :Unpaid 
  
permit_params :start_date,:end_date,:total_leave,:developer,:status
	config.batch_actions = false
	actions :all , except:[:new]

	action_item :view, only: :show do
		link_to 'Approved',  accept_path(leave_application) , method: :get,:class=>"line_spacing" if leave_application.status == "Pending"
	end

	action_item :view, only: :show do
		link_to 'Reject', reject_path(leave_application) , method: :get,:class=>"line_spacing" if leave_application.status == "Pending"
	end


	index download_links: [:csv] do
		# selectable_column
		# id_column
		column :start_date
		column :end_date
		column :total_leave
		column :developer
		column :status
		column "Leave Date", :created_at
		actions
	end
	
	filter :developer
	# filter :status 

	form do |f|
		f.inputs "Leave Application" do    
			f.input :start_date, as: :datepicker, datepicker_options: { min_date: 0,        max_date: "+3D" }
			f.input :end_date, as: :datepicker, datepicker_options: { min_date: 0,        max_date: "+3D" }
			f.input :total_leave
			f.input :developer
			f.input :status
			f.input :reason
		end
		f.actions
	end

	show :title => "Leave Application" do
		attributes_table do 
			row :start_date
			row :end_date
			row :total_leave
			row :developer
			row :status
			row :reason
			row :created_at
			row :updated_at
		end
	end

	controller do

		def accept
			@leave = ApplyLeave.find_by(:id=>params[:id]).update(:status=>1)
			flash[:notice]="Leave Approved.."
			redirect_to admin_leave_applications_path
		end

		def reject
			@leave = ApplyLeave.find_by(:id=>params[:id]).update(:status=>2)
			flash[:success]="Leave Rejected.."
			redirect_to admin_leave_applications_path
		end
	end
end
