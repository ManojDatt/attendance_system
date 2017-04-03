class TodosController < ApplicationController
	before_action :authenticate_developer!

	def new
		@todo = Todo.new
		
	end
	def create
		params[:todo][:task_name].each_with_index do |val,i|
			Todo.create(:task_name=>val,task_time: params[:todo][:task_time][i] ,project_id: params[:todo][:task_project],developer_id:current_developer.id)
		end
		redirect_to root_path
	end
end
