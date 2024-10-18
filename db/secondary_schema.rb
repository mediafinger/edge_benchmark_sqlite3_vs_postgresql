# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_10_18_205626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "pg_comments", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.boolean "active"
    t.integer "pg_stuff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pg_stuff_id"], name: "index_pg_comments_on_pg_stuff_id"
  end

  create_table "pg_reactions", force: :cascade do |t|
    t.string "body"
    t.integer "pg_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pg_comment_id"], name: "index_pg_reactions_on_pg_comment_id"
  end

  create_table "pg_stuffs", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
