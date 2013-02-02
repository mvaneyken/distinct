ActiveAdmin.register TestSuite do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.recipes'), priority: 10
  
  index do
    column :name
    column 'Standards' do |row|
      blank_when_zero row.test_standards.count
    end
    default_actions
  end
  
  form do |f|
    f.inputs do
      f.input :name
    end
    f.inputs do
      f.has_many :test_standards do |fts|
        fts.input :standard, collection: Standard.all.map {|s| [s.code_property, s.id]}
        unless fts.object.nil?
          fts.input :_destroy, as: :boolean, label: "Destroy?"
        end
      end
    end
    f.buttons
  end
  
  show do |s|
    attributes_table do
      row :name
    end
    panel "Standards" do
      table_for s.test_standards do
        column "Code" do |row|
          row.standard.code
        end
        column "Property" do |row|
          row.standard.property
        end
        column "Min Tolerance" do |row|
          row.standard.min_tolerance
        end
        column "Below Min" do |row|
          row.standard.min_tolerance_action_id ? row.standard.min_tolerance_action.colour_action : ''
        end
        column "Max Tolerance" do |row|
          row.standard.max_tolerance
        end
        column "Above Max" do |row|
          row.standard.max_tolerance_action_id ? row.standard.max_tolerance_action.colour_action : ''
        end
      end
    end
end
  
end