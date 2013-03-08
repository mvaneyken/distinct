ActiveAdmin.register ItemType do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.references'), priority: 10
  
  index do
    column :name
    column :active
    column "Item Masters" do |row|
      zero_blank row.item_masters.count
    end
    default_actions
  end
  
  show do
    attributes_table_for item_type do
      [:name, :active].each do |attr|
        row attr
      end
    end
    panel "Item Masters" do
      table_for item_type.item_masters do
        column :code do |row|
          link_to row.code, admin_item_master_path(row.id)
        end
        column :description
      end
    end
  end
  
end