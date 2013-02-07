module SessionHelpers
  
  def sign_in_as_technician
    @technician = create(:technician)
    visit new_technician_session_path
    fill_in 'Email', :with => @technician.email
    fill_in 'Password', :with => "secret_password"
    click_button "Sign in"
  end
  
  def create_test_data
    # Create some reference tables
    2.times do
      item_type = create(:item_type)
      2.times do
        test_suite = create(:test_suite)
        2.times do
          standard = create(:standard)
          equipment = create(:equipment)
          2.times do
            standard.standard_equipments.create(equipment_id: equipment.id)
          end
          standard.save!
          test_suite.test_standards.build(standard_id: standard.id)
          test_suite.save!
        end
        item_master = create(:item_master, item_type_id: item_type.id, test_suite_id: test_suite.id)
      end
    end
  end
  
  def dump_lot(lot)
    puts "LOT/"
    puts "lot=#{lot.inspect}"
    dump_item_master(lot.item_master)
  end
  
  def dump_item_master(item_master)
    puts "ITEM MASTER/"
    puts "item_master=#{item_master.inspect}"
    puts "item_type=#{item_master.item_type.inspect}"
    dump_test_suite(item_master.test_suite) if item_master.test_suite
  end
  
  def dump_test_suite(test_suite)
    puts "TEST SUITE/"
    puts "test_suite=#{test_suite.inspect}"
    puts "test_standards.count=#{test_suite.test_standards.count}"
    indx = 0
    test_suite.test_standards.each do |test_standard|
      puts "[#{indx}]=#{test_standard.inspect}; standard=#{test_standard.standard.inspect}"
      puts ">standard_equipments="
      b = 0
      test_standard.standard.standard_equipments.each do |standard_equipment|
        puts "[#{b}]=#{standard_equipment.inspect}; equipment=#{standard_equipment.equipment.inspect}"
        b += 1
      end
      indx += 1
    end
  end
  
  def dump_sample(sample)
    puts "SAMPLE/"
    puts "sample=#{sample.inspect}"
    puts "sample_equipments="
    indx = 0
    sample.sample_equipments.each do |sample_equipment|
      puts "[#{indx}]=#{sample_equipment.inspect}; equipment=#{sample_equipment.equipment.inspect}"
      indx += 1
    end
  end
      
end