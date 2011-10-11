# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110930081648) do

  create_table "briefings", :force => true do |t|
    t.integer  "role_id"
    t.text     "briefing_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "case_studies", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.boolean  "party_type"
    t.boolean  "game_type"
    t.boolean  "issue_type"
    t.boolean  "delivery_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "eval_type"
    t.integer  "case_study_type"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "client_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.integer  "player_id"
    t.boolean  "inout"
    t.boolean  "newreply"
    t.string   "to_players"
    t.string   "from_player"
    t.string   "subject"
    t.text     "mail_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilitator_groups", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "folders", :force => true do |t|
    t.integer  "player_id"
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_datas", :force => true do |t|
    t.integer  "game_id"
    t.string   "data_of"
    t.string   "data_is"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "student_group_id"
    t.integer  "case_study_id"
    t.boolean  "status"
    t.boolean  "agreement_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imports", :force => true do |t|
    t.string   "datatype"
    t.integer  "processed",        :default => 0
    t.string   "csv_file_name"
    t.string   "csv_content_type"
    t.integer  "csv_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issue_options", :force => true do |t|
    t.integer  "issue_id"
    t.string   "option"
    t.integer  "weightage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", :force => true do |t|
    t.integer  "case_study_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flag"
    t.integer  "weightage"
  end

  create_table "message_copies", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "message_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.integer  "offer"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metrics", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", :force => true do |t|
    t.integer  "game_id"
    t.integer  "offerer"
    t.integer  "value"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "option_values", :force => true do |t|
    t.integer  "issue_option_id"
    t.integer  "role_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.string   "name"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "planqs", :force => true do |t|
    t.integer  "player_id"
    t.string   "meyou"
    t.string   "name"
    t.string   "value"
    t.boolean  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_answers", :force => true do |t|
    t.integer  "player_id"
    t.integer  "question_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_scorecards", :force => true do |t|
    t.integer  "player_id"
    t.integer  "issue_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "issue_option_id"
    t.integer  "game_id"
  end

  create_table "players", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questionnaires", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "statement"
    t.integer  "questionnaire_id"
    t.integer  "type_id"
    t.integer  "category_id"
    t.text  "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.integer  "case_study_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scoreqs", :force => true do |t|
    t.integer  "player_id"
    t.integer  "student_group_metric_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "message_id"
  end

  create_table "student_group_metrics", :force => true do |t|
    t.integer  "student_group_id"
    t.integer  "metric_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_group_rules", :force => true do |t|
    t.integer  "student_group_id"
    t.integer  "rule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_group_users", :force => true do |t|
    t.integer  "student_group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_groups", :force => true do |t|
    t.integer  "facilitator_group_id"
    t.integer  "case_study_id"
    t.string   "facilitator"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_questionnaire_id"
    t.integer  "pre_questionnaire_id"
  end

  create_table "student_routings", :force => true do |t|
    t.boolean  "pre_neg_taken",     :default => false
    t.boolean  "post_neg_taken",    :default => false
    t.boolean  "pre_neg_required",  :default => false
    t.boolean  "post_neg_required", :default => false
    t.boolean  "planning_required", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
  end

  create_table "temp_users", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temps", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "facilitator_group_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "identifier"
    t.string   "username"
    t.boolean  "educator"
    t.boolean  "admin"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
