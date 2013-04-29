ActiveAdmin.register Standard do
  config.sort_order = "code_asc"
  menu parent: I18n.t('admin.recipes'), priority: 20
  actions :all, except: [:destroy]
  
  index do
    column :code
    column :property
    column 'Min' do |row|
      blank_when_zero row.min_tolerance
    end
    column 'Below Min' do |row|
      row.min_tolerance_action_id ? row.min_tolerance_action.colour_name : ''
    end
    column 'Max' do |row|
      blank_when_zero row.max_tolerance
    end
    column 'Above Max' do |row|
      row.max_tolerance_action_id ? row.max_tolerance_action.colour_name : ''
    end
    column :measure
    column "Equipment" do |row|
      list = []
      row.standard_equipments.each {|se| list << se.equipment.name}
      list.join(', ')
    end
    column("View") {|row| link_to "View", admin_standard_path(row)}
    column("Edit") {|row| link_to "Edit", edit_admin_standard_path(row)}
    column "Delete" do |row|
      if row.can_delete?
        link_to "Delete", admin_standard_path(row), action: :delete
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :code
      f.input :property
      f.input :measure, collection: Measure.order(:code).map{|o| [o.code, o.id]}
      f.input :min_tolerance
      f.input :min_tolerance_message, as: :autocomplete, url: autocomplete_admin_tolerance_action_message_admin_tolerance_actions_path
      f.input :max_tolerance
      f.input :max_tolerance_message, as: :autocomplete, url: autocomplete_admin_tolerance_action_message_admin_tolerance_actions_path
    end
    f.inputs do
      f.has_many :standard_equipments do |se|
        se.input :equipment, collection: Equipment.all.map {|o| [o.name, o.id]}
        unless se.object.nil?
          se.input :_destroy, as: :boolean, label: "Destroy?"
        end
      end
    end
    f.buttons
  end
  
  show do |v|
    attributes_table do
      row :code
      row :property
      row :min_tolerance
      row "Below Min" do |row|
        v.min_tolerance_action_id ? v.min_tolerance_action.colour_action : ''
      end
      row :max_tolerance
      row "Above Max" do |row|
        v.max_tolerance_action_id ? v.max_tolerance_action.colour_action : ''
      end
    end
    panel "Used in the following Test Suites:" do
      paginated_collection(standard.test_standards.page(params[:page])) do
        table_for collection do
          column("Id")      {|test_standard| link_to test_standard.test_suite_id, admin_test_suite_path(test_standard.test_suite_id)}
          column("Name")    {|test_standard| test_standard.test_suite.name}
        end
      end
    end
  end
  
end