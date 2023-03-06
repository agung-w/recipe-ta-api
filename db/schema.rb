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

ActiveRecord::Schema[7.0].define(version: 2023_03_05_110129) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cooking_steps", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.integer "step", null: false
    t.string "description", limit: 1000, null: false
    t.string "pic_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_cooking_steps_on_recipe_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", null: false
    t.string "pic_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metrics", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "abbrev", limit: 6, null: false
    t.float "volume"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_ingredients", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.integer "quantity"
    t.bigint "metric_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["metric_id"], name: "index_recipe_ingredients_on_metric_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipe_tags", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipe_tags_on_tag_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.string "poster_pic_url"
    t.string "description", limit: 1000, null: false
    t.integer "favorite_count", default: 0
    t.integer "prep_time", null: false
    t.integer "serving", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_pic_url"
    t.integer "followers_count", default: 0
    t.integer "following_count", default: 0
    t.integer "bookmark_count", default: 0
    t.integer "posted_recipe_count", default: 0
  end

  add_foreign_key "cooking_steps", "recipes"
  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "metrics"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipe_tags", "recipes"
  add_foreign_key "recipe_tags", "tags"
  add_foreign_key "recipes", "users"
end
