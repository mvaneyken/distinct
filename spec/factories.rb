FactoryGirl.define do
  
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
  end
  
  factory :standard_equipment do
    :standard
    :equipment
  end
  
  factory :test_standard do
    test_suite
    standard
  end
  
  factory :item_master do
    item_type
    sequence(:code) {|n| "code #{n}"}
    description "a description"
    test_suite
    measure
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
    sequence(:comments) {|n| "Comment #{n}"}
  end
  
end