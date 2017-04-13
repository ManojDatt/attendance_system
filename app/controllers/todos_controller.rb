class TodosController < ApplicationController
	before_action :authenticate_developer!
	before_action :get_todo, :only => [:show, :reply_dsr]
	layout "developer_layout"
	def index
		if params[:date].present?
			p""
		else	
		@dsrs = current_developer.todos.where("created_at::date >= ?", (Time.current.-2.day).to_date)
		end
	end
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

	def show
		if @dsr.dsr_replies.present?
			@replies = @dsr.dsr_replies
			@replies.where(seen:false).update(seen:true)
		end
	end

	def submit_research
		params[:todo][:task_name].each_with_index do |val,i|
			Todo.create(:task_name=>val,task_time: "#{params[:todo][:hours][i]}:#{params[:todo][:minutes][i]}" ,project_id: params[:todo][:task_project],developer_id:current_developer.id,task_type: "Research")
		end
		flash['success'] ="R&D submited successfully..."
		redirect_to root_path
	end

	def reply_dsr
		@dsr.dsr_replies.create(message:params[:reply][:message])
		flash[:warning] = "You have repleid on DSR # #{@dsr.id}."
		redirect_to todos_path
	end

	private

	def get_todo
		@dsr = Todo.find_by_id(params[:id])
	end

end