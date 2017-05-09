ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate", style:"width:30%;" do
        h2 "Welcome"
       span do
        image_tag"logo.png"
       end 
      end
    end

  end 
end
