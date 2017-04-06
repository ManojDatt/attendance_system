class LeavesController < ApplicationController
	layout "developer_layout"
  before_action :authenticate_developer!

	def index
		@leave = current_developer.leave		
	end
	
	# def new
		
	# end
end
