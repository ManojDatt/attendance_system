class TodosController < ApplicationController
	before_action :authenticate_developer!
	layout "developer_layout"
	def new
		@todo = Todo.new		
	end
	def create
		params[:todo][:task_name].each_with_index do |val,i|
			Todo.create(:task_name=>val,task_time: "#{params[:todo][:hours][i]}:#{params[:todo][:minutes][i]}",project_id: params[:todo][:task_project],developer_id:current_developer.id,task_type: "Task")
		end
		flash['success'] ="DSR submited successfully..."
		redirect_to root_path
	end

	def today_research

	end

	def submit_research
		params[:todo][:task_name].each_with_index do |val,i|
			Todo.create(:task_name=>val,task_time: "#{params[:todo][:hours][i]}:#{params[:todo][:minutes][i]}" ,project_id: params[:todo][:task_project],developer_id:current_developer.id,task_type: "Research")
		end
		flash['success'] ="R&D submited successfully..."
		redirect_to root_path
	end

end