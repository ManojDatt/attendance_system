ActiveAdmin.register Leave do
permit_params :total_leave,:available_leave,:developer
	config.batch_actions = false
	actions :all,except:[:new]

	index download_links: [:csv] do
		# id_column
		column :total_leave
		column :available_leave
		column :developer
		column "Created Date", :created_at
		actions
	end

	filter :developer

	form do |f|
		f.inputs "Leave" do		
			f.input :total_leave
			f.input :available_leave
			f.input :developer
		end
		f.actions
	end

	show :title => "Leave" do
		attributes_table do 
			row :total_leave
			row :available_leave
			row :developer	
			row :created_at
			row :updated_at
		end
	end 
end
