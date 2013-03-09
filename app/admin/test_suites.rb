ActiveAdmin.register TestSuite do
  config.sort_order = "name_asc"
  menu parent: I18n.t('admin.recipes'), priority: 10
  
  member_action :duplicate, :method => :put do
    source = TestSuite.find(params[:id])
    @test_suite = TestSuite.duplicate(source)
    redirect_to admin_test_suites_path, :notice => "#{@test_suite.name} created"
  end
  
  index do
    column :name
    column 'Standards' do |row|
      blank_when_zero row.test_standards.count
    end
    column 'Duplicate' do |row|
      link_to "Duplicate", duplicate_admin_test_suite_path(row), method: :put
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
  
  show do 
    attributes_table do
      row :name
    end
    panel " Test Standards" do
      table_for test_suite.test_standards do 
        column "Code" do |row|
          link_to row.standard.code, admin_standard_path(row.id)
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