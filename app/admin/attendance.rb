ActiveAdmin.register Attendance do
	permit_params :punch_in_time,:punch_out_time,:extra_work,:work_hour,:lat_in,:early_out,:developer,:punch_out_status
	config.batch_actions = false
	actions :all , except:[:new,:destroy]
	index download_links: [:csv] do
		# selectable_column
		id_column
		column :punch_in_time
		column :punch_out_time do |f|
			if f.punch_out_time.present?
				f.punch_out_time
			else
				"--"
			end
		end
		column :extra_work do |f|
			if f.extra_work.present?
				f.extra_work
			else
				"--"
			end
		end
		column :lat_in
		column :early_out
		column :developer
		column "Date", :created_at
		actions
	end

	filter :punch_in_time
	filter :punch_out_time
	filter :extra_work
	filter :lat_in
	filter :early_out
	filter :developer

	form do |f|
		f.inputs "Attendance" do    
			f.input :punch_in_time, as: :datepicker, datepicker_options: { min_date: 0,        max_date: "+3D" }
			f.input :punch_out_time, as: :datepicker, datepicker_options: { min_date: 0,        max_date: "+3D" }
			f.input :extra_work
			f.input :punch_out_status, as: :boolean
			f.input :lat_in, as: :datepicker, datepicker_options: { min_date: "2013-10-8",        max_date: "+3D" }
			f.input :early_out, as: :datepicker, datepicker_options: { min_date: "2013-10-8",        max_date: "+3D" }
		end
		f.actions
	end

	show :title => "Attendance" do
		attributes_table do 
			row :punch_in_time
			row :punch_out_time
			row :extra_work
			row :lat_in
			row :early_out
			row :developer
			row :created_at
			row :updated_at
		end
	end 
end
