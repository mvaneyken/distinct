ActiveAdmin.register ConsumptionProfile do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.installations')
  actions :all, except: [:destroy]
  
  index do
    column :code
    column :name
    column("View") {|row| link_to "View", admin_consumption_profile_path(row)}
    column("Edit") {|row| link_to "Edit", edit_admin_consumption_profile_path(row)}
    column "Delete" do |row|
      if row.can_delete?
        link_to "Delete", admin_consumption_profile_path(row), action: :delete
      end
    end
  end
  
  show do
    attributes_table_for consumption_profile do
      [:code, :name].each do |attr|
         row attr
       end
    end
    panel "Used for the following installations" do
      table_for consumption_profile.installations do
        column(:client) {|installation| installation.client_name}
        column(:representative) {|installation| installation.representative_name}
        column(:location) {|installation| installation.location}
        column(:installed) {|installation| installation.installed.strftime('%Y/%m/%d')}
      end
    end
  end
  
end