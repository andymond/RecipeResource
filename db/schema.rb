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

ActiveRecord::Schema.define(version: 20180418180455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_credentials", force: :cascade do |t|
    t.string "password_digest"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_app_credentials_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "author"
    t.text "body"
    t.bigint "recipe_id"
    t.index ["recipe_id"], name: "index_comments_on_recipe_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_favorites_on_recipe_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "google_credentials", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "refresh_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_google_credentials_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instructions", force: :cascade do |t|
    t.text "step"
    t.bigint "recipe_id"
    t.index ["recipe_id"], name: "index_instructions_on_recipe_id"
  end

  create_table "recipe_images", force: :cascade do |t|
    t.string "recipe_image"
    t.bigint "recipe_id"
    t.string "caption"
    t.index ["recipe_id"], name: "index_recipe_images_on_recipe_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "ingredient_id"
    t.decimal "quantity"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "station"
    t.string "name"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["restaurant_id"], name: "index_recipes_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "yid"
    t.string "image_url", default: "cutlery.svg"
    t.string "rating"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zipcode"
    t.string "name"
    t.string "slug"
    t.text "yelp_url"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.bigint "restaurant_id"
    t.index ["restaurant_id"], name: "index_user_roles_on_restaurant_id"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.text "image_url", default: "default-profile.png"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "app_credentials", "users"
  add_foreign_key "comments", "recipes"
  add_foreign_key "favorites", "recipes"
  add_foreign_key "favorites", "users"
  add_foreign_key "google_credentials", "users"
  add_foreign_key "instructions", "recipes"
  add_foreign_key "recipe_images", "recipes"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "restaurants"
  add_foreign_key "user_roles", "restaurants"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
