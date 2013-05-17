# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130506203632) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "clients", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "consumption_profiles", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "equipment", :force => true do |t|
    t.string   "name"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "serial_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "ink_systems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "installations", :force => true do |t|
    t.integer  "client_id"
    t.string   "location"
    t.integer  "printer_model_id"
    t.integer  "ink_system_id"
    t.date     "installed_date"
    t.integer  "consumption_profile_id"
    t.integer  "representative_id"
    t.integer  "printer_function_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "item_masters", :force => true do |t|
    t.integer  "item_type_id"
    t.string   "code"
    t.string   "description"
    t.integer  "test_suite_id"
    t.integer  "measure_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lot_versions", :force => true do |t|
    t.integer  "lot_id"
    t.integer  "version"
    t.string   "comments"
    t.integer  "technician_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "lots", :force => true do |t|
    t.integer  "item_master_id"
    t.boolean  "pass"
    t.string   "comments"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "lot_number"
  end

  create_table "measures", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "printer_functions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "printer_models", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "representatives", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "representatives", ["email"], :name => "index_representatives_on_email", :unique => true
  add_index "representatives", ["reset_password_token"], :name => "index_representatives_on_reset_password_token", :unique => true

  create_table "samples", :force => true do |t|
    t.integer  "standard_id"
    t.integer  "equipment_id"
    t.integer  "technician_id"
    t.decimal  "value"
    t.boolean  "pass"
    t.string   "comments"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "lot_version_id"
    t.integer  "data_version_id"
  end

  create_table "standard_equipments", :force => true do |t|
    t.integer  "standard_id"
    t.integer  "equipment_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "standards", :force => true do |t|
    t.string   "code"
    t.string   "property"
    t.decimal  "min_tolerance",           :precision => 7, :scale => 2
    t.integer  "min_tolerance_action_id"
    t.decimal  "max_tolerance",           :precision => 7, :scale => 2
    t.integer  "max_tolerance_action_id"
    t.integer  "measure_id"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  create_table "technicians", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "technicians", ["email"], :name => "index_technicians_on_email", :unique => true
  add_index "technicians", ["reset_password_token"], :name => "index_technicians_on_reset_password_token", :unique => true

  create_table "test_standards", :force => true do |t|
    t.integer  "test_suite_id"
    t.integer  "standard_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "test_suites", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tolerance_actions", :force => true do |t|
    t.string   "message"
    t.string   "colour"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_foreign_key "item_masters", "item_types", :name => "item_masters_item_type_id_fk"
  add_foreign_key "item_masters", "test_suites", :name => "item_masters_test_suite_id_fk"

  add_foreign_key "lot_versions", "lots", :name => "lot_versions_lot_id_fk"

  add_foreign_key "lots", "item_masters", :name => "lots_item_master_id_fk"

  add_foreign_key "samples", "equipment", :name => "samples_equipment_id_fk"
  add_foreign_key "samples", "lot_versions", :name => "samples_data_version_id_fk", :column => "data_version_id"
  add_foreign_key "samples", "lot_versions", :name => "samples_lot_version_id_fk"
  add_foreign_key "samples", "standards", :name => "samples_standard_id_fk"
  add_foreign_key "samples", "technicians", :name => "samples_technician_id_fk"

  add_foreign_key "standard_equipments", "equipment", :name => "standard_equipments_equipment_id_fk"
  add_foreign_key "standard_equipments", "standards", :name => "standard_equipments_standard_id_fk"

  add_foreign_key "standards", "measures", :name => "standards_measure_id_fk"
  add_foreign_key "standards", "tolerance_actions", :name => "standards_max_tolerance_action_id_fk", :column => "max_tolerance_action_id"
  add_foreign_key "standards", "tolerance_actions", :name => "standards_min_tolerance_action_id_fk", :column => "min_tolerance_action_id"

  add_foreign_key "test_standards", "standards", :name => "test_standards_standard_id_fk"
  add_foreign_key "test_standards", "test_suites", :name => "test_standards_test_suite_id_fk"

end
