ActiveAdmin.register Notification do
actions :all,except:[:new, :show,:edit]
filter :developer
filter :created_at

	index download_links: [:csv] do
		selectable_column
		column :message
		column "Seen",:unseen do |notification|
			if notification.unseen
				("<span class='status_tag no'>No</span>").html_safe
			else
				("<span class='status_tag yes'>Yes</span>").html_safe
			end		
		end
		column "Punched On",:created_at
		actions 
	end

	
end	