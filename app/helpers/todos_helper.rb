module TodosHelper
	def count_unseen_reply(todo)
		todo.dsr_replies.where(seen:false).count
	end
end
