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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180902103456) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "pos"
    t.text     "size"
    t.text     "echo"
    t.text     "comp"
    t.text     "form"
    t.text     "edge"
    t.text     "calc"
    t.text     "color"
    t.text     "spec"
    t.text     "elas"
    t.text     "spare"
    t.text     "symp"
    t.text     "sign"
    t.text     "bio"
    t.text     "path"
    t.text     "treat"
    t.text     "aut"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "job_imports", force: :cascade do |t|
    t.string   "status"
    t.string   "csv_file"
    t.text     "title"
    t.text     "description"
    t.text     "num"
    t.text     "pos"
    t.text     "aut"
    t.text     "size"
    t.text     "echo"
    t.text     "comp"
    t.text     "form"
    t.text     "edge"
    t.text     "calc"
    t.text     "color"
    t.text     "spec"
    t.text     "elas"
    t.text     "symp"
    t.text     "sign"
    t.text     "bio"
    t.text     "path"
    t.text     "hct"
    t.text     "treat"
    t.text     "spare"
    t.text     "person"
    t.text     "paper"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "pos"
    t.text     "size"
    t.text     "echo"
    t.text     "comp"
    t.text     "form"
    t.text     "edge"
    t.text     "calc"
    t.text     "color"
    t.text     "spec"
    t.text     "elas"
    t.text     "spare"
    t.text     "symp"
    t.text     "sign"
    t.text     "bio"
    t.text     "path"
    t.text     "treat"
    t.text     "aut"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "wage_upper_bound"
    t.integer  "wage_lower_bound"
    t.string   "contact_email"
    t.boolean  "is_hidden",        default: true
    t.string   "image"
    t.string   "images"
    t.string   "friendly_id"
    t.text     "num"
    t.text     "paper"
    t.text     "person"
    t.text     "hct"
    t.text     "apple"
    t.text     "ori"
    t.text     "seltrdes"
    t.text     "seltrpos"
    t.text     "seltrecho"
    t.text     "seltrcomp"
    t.text     "seltredge"
    t.text     "seltrcalc"
    t.text     "catamenta"
    t.text     "opare"
    t.text     "read"
    t.index ["friendly_id"], name: "index_jobs_on_friendly_id", unique: true
  end

  create_table "resumes", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "attachment"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_admin",               default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
