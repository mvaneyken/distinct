ActiveAdmin.register Measure do
  config.sort_order = "code_asc"
  menu parent: I18n.t('admin.references'), priority: 30
  
  index do
    column :code
    column :name
    column :description
    column "Standards" do |row|
      zero_blank row.standards.count
    end
    default_actions
  end
  
  show do
    attributes_table do
      row :code
      row :name
      row :description
    end
    panel "Standards" do
      table_for measure.standards do |standard|
        column :code do |row|
          link_to row.code, admin_standard_path(row.id)
        end
        column :property
        column :min_tolerance
        column :max_tolerance
      end
    end
  end    
    
end