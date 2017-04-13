ActiveAdmin.register Todo ,as: "DSR" do

  scope :research
  scope :task 
  # scope :user
  # scope :daily(todo)

	permit_params :task_name,:task_time,:task_type,:project,:developer
	config.batch_actions = false
	actions :all,except:[:new, :destroy]

	index download_links: [:csv] do
		column "DSR Number", :id
		column "Task name" do |body|
              truncate(body.task_name, omision: "...", length: 50)
        end
		column "Task Duration (H:M)",:task_time
		column :task_type
		column :project
		column :developer
		column "Created Date", :created_at
		column() {|todo| link_to ("Reply <span style='color:green;'>(#{todo.dsr_replies.where(seen:false).count})</span>").html_safe, admin_reply_dsr_path(todo), method: :post}
		actions
	end

	filter :project
	filter :developer
	filter :created_at

	form do |f|
		f.inputs "Todo" do
			f.input :project
			f.input :task_name
			f.input :task_time
			f.input :task_type
			f.input :developer
		end
		f.actions
	end

	show :title => "Todo" do
		attributes_table do
			row :project
			row :task_name
			row :task_time
			row :task_type
			row :developer
			row :created_at
			row :updated_at
		end
	end 

	member_action :reply_dsr do
		@dsr = Todo.find_by(:id=>params[:id])
		@developer = @dsr.developer
		@replies = @dsr.dsr_replies
		if params['commit']=="Reply"
			flash[:warning] = "You have repleid on DSR # #{@dsr.id}."
			@dsr.dsr_replies.create(message:params[:reply][:message])
			message= "You have received one reply on your DSR #{@dsr.id}."
			@developer.notifications.create(message: message, notification_type:'dsr-reply')
			redirect_to admin_dsrs_path
		end
	end
end
