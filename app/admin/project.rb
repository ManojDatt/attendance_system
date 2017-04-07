ActiveAdmin.register Project do

permit_params :name,:domain
	config.batch_actions = false
	actions :all

	index download_links: [:csv] do
		# id_column
		column :name
		column :domain
		column "Created Date", :created_at
		actions
	end

	filter :name
	filter :domain	

	form do |f|
		f.inputs "Project" do
			f.input :name
			f.input :domain
		end
		f.actions
	end

	show :title => "Project" do
		attributes_table do 
			row :name
			row :domain			
			row :created_at
			row :updated_at
		end
	end 
end
