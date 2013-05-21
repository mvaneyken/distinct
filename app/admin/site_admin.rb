ActiveAdmin.register_page "Site Admin" do

  menu :priority => 99, :label => proc{ I18n.t("admin.site_admin") }
  
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    
    columns do
      column do
        panel "Installed Base" do
          para 'You can add a batch of installations by uploading a csv (comma seperated values) file. The file must have the following columns:'
          ul do
            li "client_code".titleize
            li "client_name".titleize
            li "printer_model_name".titleize
            li "ink_system_name".titleize
            li "consumption_profile_code".titleize
            li "printer_function_name".titleize
            li "representative_name".titleize
            li "location".titleize
            li "Installed date (YYYY/MM/DD format)"
          end
          para "Remember to encapsulate a column with quotes (\") if you use special characters (like commas). Code columns will be converted to uppercase and shouldn't have any blanks"
        end
      end
      column do
        panel "Upload" do
          render 'installations'
        end
      end
    end
    
  end
end