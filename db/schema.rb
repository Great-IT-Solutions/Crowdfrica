# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_09_211032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "fullname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true
  end

  create_table "admins", id: :serial, force: :cascade do |t|
    t.string "fullname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "beneficiaries", id: :serial, force: :cascade do |t|
    t.integer "btype", default: 0, null: false
    t.string "beneficiary_name", default: "", null: false
    t.string "country", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "tags", array: true
    t.bigint "author_id", null: false
    t.string "image_url", default: "", null: false
    t.text "author_bio"
    t.index ["author_id"], name: "index_blog_posts_on_author_id"
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true
    t.index ["title"], name: "index_blog_posts_on_title", unique: true
  end

  create_table "campaigns", id: :serial, force: :cascade do |t|
    t.string "campaign_headline", default: "", null: false
    t.string "campaign_image_url", default: "", null: false
    t.string "campaign_video_url", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.string "slug"
    t.string "campaign_name"
    t.boolean "published", default: false, null: false
    t.index ["project_id"], name: "index_campaigns_on_project_id"
    t.index ["slug"], name: "index_campaigns_on_slug", unique: true
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "category_name", default: "", null: false
    t.string "category_description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "championship_requests", id: :serial, force: :cascade do |t|
    t.integer "champion_id", null: false
    t.integer "campaign_id", null: false
    t.text "reason"
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "authorized", default: false
    t.text "message"
    t.boolean "declined", default: false
  end

  create_table "championships", id: :serial, force: :cascade do |t|
    t.integer "champion_id", null: false
    t.integer "campaign_id", null: false
    t.string "relationship"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_championships_on_campaign_id", unique: true
    t.index ["champion_id"], name: "index_championships_on_champion_id", unique: true
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "body", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.string "commenter_type", null: false
    t.bigint "commenter_id", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["commenter_type", "commenter_id"], name: "index_comments_on_commenter_type_and_commenter_id"
  end

  create_table "donations", id: :serial, force: :cascade do |t|
    t.decimal "amount", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "donor_id"
    t.integer "project_id"
    t.string "token"
    t.boolean "anonymous", default: false, null: false
    t.string "via"
    t.string "order_id"
    t.string "order_status", default: ""
    t.decimal "ghs_amount", default: "0.0"
    t.string "flw_ref"
    t.decimal "tip", default: "0.0"
    t.decimal "ngn_amount", default: "0.0"
    t.decimal "kes_amount", default: "0.0"
    t.decimal "ngn_tips", default: "0.0"
    t.decimal "kes_tips", default: "0.0"
    t.decimal "ghs_tips", default: "0.0"
    t.index ["donor_id"], name: "index_donations_on_donor_id"
    t.index ["project_id"], name: "index_donations_on_project_id"
  end

  create_table "donors", id: :serial, force: :cascade do |t|
    t.string "fullname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gender"
    t.boolean "admin", default: false
    t.string "country"
    t.string "slug"
    t.string "stripe_customer_id"
    t.boolean "registered", default: false, null: false
    t.boolean "has_a_stripe_customer_account", default: false, null: false
    t.string "image"
    t.string "color", default: "#ff5103", null: false
    t.string "provider"
    t.string "uid"
    t.string "phone"
    t.string "square_customer_id"
    t.boolean "has_a_square_customer_account", default: false, null: false
    t.string "mobile_number"
    t.index ["email"], name: "index_donors_on_email", unique: true
    t.index ["mobile_number"], name: "index_donors_on_mobile_number", unique: true
    t.index ["reset_password_token"], name: "index_donors_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_donors_on_slug", unique: true
  end

  create_table "exrates", id: :serial, force: :cascade do |t|
    t.decimal "rate", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "ngn_rate", default: "0.0", null: false
    t.decimal "kes_rate", default: "0.0", null: false
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "interpay_payment_logs", id: :serial, force: :cascade do |t|
    t.integer "donation_id"
    t.text "payment_log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paypal_payment_logs", force: :cascade do |t|
    t.bigint "donation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["donation_id"], name: "index_paypal_payment_logs_on_donation_id"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "project_name", null: false
    t.text "project_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expires_at"
    t.integer "beneficiary_id"
    t.integer "category_id"
    t.string "slug"
    t.string "ailment_or_equipment", default: "", null: false
    t.decimal "cost", default: "0.0", null: false
    t.date "date_funded"
    t.decimal "medical_cost", default: "0.0", null: false
    t.decimal "equipment_cost", default: "0.0", null: false
    t.decimal "year_cost", default: "0.0", null: false
    t.decimal "renewal", default: "0.0", null: false
    t.decimal "processing", default: "0.0", null: false
    t.decimal "operational_costs", default: "0.0", null: false
    t.index ["beneficiary_id"], name: "index_projects_on_beneficiary_id"
    t.index ["category_id"], name: "index_projects_on_category_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "providers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "location"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rave_payment_logs", id: :serial, force: :cascade do |t|
    t.integer "donation_id"
    t.text "payment_log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donation_id"], name: "index_rave_payment_logs_on_donation_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blog_posts", "admin_users", column: "author_id"
  add_foreign_key "campaigns", "projects"
  add_foreign_key "donations", "donors"
  add_foreign_key "donations", "projects"
  add_foreign_key "paypal_payment_logs", "donations"
  add_foreign_key "projects", "beneficiaries"
  add_foreign_key "projects", "categories"
end
