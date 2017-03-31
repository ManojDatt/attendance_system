RailsAdmin.config do |config|
  config.main_app_name = ["Arka Softwares", "Attendance system"]
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  config.model "Admin" do
    list do
      field :id
      field :email
      field :created_at do
        searchable false
        label "date of registration"
      end
      items_per_page 10
    end
  end
  config.model 'Attendance' do
    list do
      field :id
      field :developer
      field :punch_in_time
      field :punch_out_time
      field :created_at do
        searchable false
        label "date"
      end
      items_per_page 10

    end
    show do
      field :id
      field :developer
      field :punch_in_time
      field :punch_out_time
      field :created_at
      field :updated_at
    end
    edit do        
      field :developer
      field :punch_in_time
      field :punch_out_time
    end
  end

  config.model 'Developer' do   
    list do
      field :id do
        searchable false
        column_width 3
        label "Developer Id"
      end
      field :username do
        column_width 100
        label "Developer Name"
      end
      field :email do
        column_width 100
        label "Developer Email"
      end
      items_per_page 10
    end
    show do
      field :id
      field :email
      field :username
      field :domain
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :created_at
      field :updated_at
    end
    edit do        
      field :email 
      field :username
      field :domain
      field :password  do
        help 'Please enter your current password'
      end
    end
    create do
      field :email
      field :username
      field :domain
      field :password
    end
  end

  config.actions do
    dashboard     # mandatory
    index                         # mandatory
    new do
      except ['Attendance']
    end
    export
    bulk_delete
    show
    edit
    delete
  end
end
