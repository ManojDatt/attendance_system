ActiveAdmin.register Todo ,as: "DSR" do

  scope :research
  scope :task 
  # scope :user
  # scope :daily(todo)

	permit_params :task_name,:task_time,:task_type,:project,:developer
	config.batch_actions = false
	actions :all,except:[:new,:destroy]

	index download_links: [:csv] do
		# id_column
		column "Task name" do |body|
              truncate(body.task_name, omision: "...", length: 50)
      end
		column :task_time
		column :task_type
		column :project
		column :developer
		column "Created Date", :created_at
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
end
