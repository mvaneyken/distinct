ActiveAdmin.register PrinterModel do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.installations')
  actions :all, except: [:destroy]
  
  index do
    column :name
    column("View") {|row| link_to "View", admin_printer_model_path(row)}
    column("Edit") {|row| link_to "Edit", edit_admin_printer_model_path(row)}
    column "Delete" do |row|
      if row.can_delete?
        link_to "Delete", admin_printer_model_path(row), action: :delete
      end
    end
  end
  
  show do
    attributes_table_for printer_model do
      [:name].each do |attr|
         row attr
       end
    end
    panel "Used for the following installations" do
      table_for printer_model.installations do
        column(:client) {|installation| installation.client_name}
        column(:representative) {|installation| installation.representative_name}
        column(:location) {|installation| installation.location}
        column(:installed) {|installation| installation.installed.strftime('%Y/%m/%d')}
      end
    end
  end
  
end