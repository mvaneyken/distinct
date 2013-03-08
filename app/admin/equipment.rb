ActiveAdmin.register Equipment do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.resources')
  
  index do
    column :name
    column :manufacturer
    column :model
    column :serial_number
    column "Standards" do |row|
      zero_blank row.standard_equipments.count
    end
    default_actions
  end
  
  show do
    attributes_table_for equipment do
      [:name, :manufacturer, :model, :serial_number].each do |attr|
         row attr
       end
    end
    panel "Used for the following standards" do
      table_for equipment.standard_equipments do
        column :standard do |row|
          link_to row.standard.code, admin_standard_path(row.standard_id)
        end
        column "Minimum" do |row|
          row.standard.min_with_measure
        end
        column "Maximum" do |row|
          row.standard.max_with_measure
        end
      end
    end
  end
  
end