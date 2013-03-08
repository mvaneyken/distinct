FactoryGirl.define do
  
  factory :admin_user do
    sequence(:email)      {|n| "admin#{n}@verajet.com"}
    password              'password'
    password_confirmation 'password'
  end
  
  factory :equipment do
    sequence(:name) {|n| "machine_#{n}"}
    manufacturer "a manufacturer"
    model "a model"
    sequence(:serial_number) {|n| "s/n #{n}"}
  end
  
  factory :measure do
    sequence(:code) {|n| "code#{n}"}
    sequence(:name) {|n| "u/m #{n}"}
    description "a description"
  end
  
  factory :item_type do
    sequence(:name) {|n| "item type #{n}"}
    active true
  end
  
  factory :test_suite do
    sequence(:name) {|n| "test suite #{n}"}
    
    factory :test_suite_with_standards do
      ignore do
        test_standards_count 3
      end
      after(:create) do |test_suite, evaluator|
        FactoryGirl.create_list(:test_standard_with_equipment, evaluator.test_standards_count, test_suite: test_suite)
      end
    end
  end
  
  factory :tolerance_action do
    sequence(:message) {|n| "action msg #{n}"}
    sequence(:colour) {|n| ToleranceAction::COLOURS[n % ToleranceAction::COLOURS.count][1]}
  end
  
  factory :standard do
    sequence(:code) {|n| "code #{n}"}
    property "a property"
    sequence(:min_tolerance) {|n| n}
    sequence(:max_tolerance) {|n| n*10}
    measure
    
    factory :standard_with_equipment do
      ignore do
        equipment_count 1
      end
      after(:create) do |standard, evaluator|
        FactoryGirl.create_list(:standard_equipment, evaluator.equipment_count, standard: standard)
      end
    end
  end
  
  factory :standard_equipment do
    standard
    equipment
  end
  
  factory :test_standard do
    test_suite
    standard
    
    factory :test_standard_with_equipment do
      standard {create(:standard_with_equipment)}
    end
  end
  
  factory :item_master do
    item_type
    sequence(:code) {|n| "code #{n}"}
    description "a description"
    test_suite
    measure
    
    factory :item_master_with_test_suite do
      test_suite {create(:test_suite_with_standards)}
    end
  end
  
  factory :technician do
    sequence(:email) {|n| "name#{n}@company.com"}
    sequence(:first_name) {|n| "John Q#{n}"}
    last_name "Public"
    password "secret_password"
    password_confirmation "secret_password"
  end
  
  factory :lot do
    item_master
    sequence(:lot_number) {|n| "#{n}-001"}
    sequence(:comments) {|n| "Comment #{n}"}
  end
  
  factory :lot_version do
    lot
    technician
  end
  
  factory :sample do
    standard
    equipment
    technician
    sequence(:value) {|n| 10+n}
    lot_version
  end
  
end
