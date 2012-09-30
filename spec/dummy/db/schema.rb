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

ActiveRecord::Schema.define(:version => 20120930125253) do

  create_table "ecm_cms_folders", :force => true do |t|
    t.string   "basename"
    t.string   "pathname"
    t.integer  "children_count",          :default => 0, :null => false
    t.integer  "ecm_cms_templates_count", :default => 0, :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "ecm_cms_folders", ["parent_id"], :name => "index_ecm_cms_folders_on_parent_id"

  create_table "ecm_cms_navigation_items", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "key"
    t.string   "options"
    t.integer  "ecm_cms_navigation_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "slug"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "ecm_cms_navigation_items", ["ecm_cms_navigation_id"], :name => "index_ecm_cms_navigation_items_on_ecm_cms_navigation_id"
  add_index "ecm_cms_navigation_items", ["parent_id"], :name => "index_ecm_cms_navigation_items_on_parent_id"

  create_table "ecm_cms_navigations", :force => true do |t|
    t.string   "locale"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ecm_cms_pages", :force => true do |t|
    t.string   "basename"
    t.string   "pathname"
    t.string   "title"
    t.text     "meta_description"
    t.text     "body"
    t.string   "layout"
    t.string   "locale"
    t.string   "format"
    t.string   "handler"
    t.integer  "ecm_cms_folder_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "ecm_cms_pages", ["ecm_cms_folder_id"], :name => "index_ecm_cms_pages_on_ecm_cms_folder_id"

  create_table "ecm_cms_partials", :force => true do |t|
    t.string   "basename"
    t.string   "pathname"
    t.text     "body"
    t.string   "layout"
    t.string   "locale"
    t.string   "format"
    t.string   "handler"
    t.integer  "ecm_cms_folder_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "ecm_cms_partials", ["ecm_cms_folder_id"], :name => "index_ecm_cms_partials_on_ecm_cms_folder_id"

  create_table "ecm_cms_templates", :force => true do |t|
    t.string   "basename"
    t.string   "pathname"
    t.text     "body"
    t.string   "layout"
    t.string   "locale"
    t.string   "format"
    t.string   "handler"
    t.integer  "ecm_cms_folder_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "ecm_cms_templates", ["ecm_cms_folder_id"], :name => "index_ecm_cms_templates_on_ecm_cms_folder_id"

end
