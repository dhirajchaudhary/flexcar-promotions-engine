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

ActiveRecord::Schema[7.1].define(version: 2025_11_21_101812) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity", default: 0
    t.integer "weight_grams", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "promotion_application_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["item_id"], name: "index_cart_items_on_item_id"
    t.index ["promotion_application_id"], name: "index_cart_items_on_promotion_application_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price_cents", default: 0, null: false
    t.integer "unit", default: 0, null: false
    t.integer "weight_per_unit_grams", default: 0
    t.bigint "category_id"
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "promotion_applications", force: :cascade do |t|
    t.bigint "promotion_id", null: false
    t.bigint "cart_item_id", null: false
    t.integer "applied_quantity", default: 0
    t.integer "original_price_cents", default: 0, null: false
    t.integer "discounted_price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_promotion_applications_on_cart_item_id"
    t.index ["promotion_id"], name: "index_promotion_applications_on_promotion_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "discount_type", default: 0, null: false
    t.decimal "discount_value", precision: 8, scale: 2
    t.integer "buy_quantity"
    t.integer "get_quantity"
    t.integer "threshold_grams"
    t.bigint "item_id"
    t.bigint "category_id"
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_promotions_on_category_id"
    t.index ["item_id"], name: "index_promotions_on_item_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "items"
  add_foreign_key "cart_items", "promotion_applications"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "promotion_applications", "cart_items"
  add_foreign_key "promotion_applications", "promotions"
  add_foreign_key "promotions", "categories"
  add_foreign_key "promotions", "items"
end
