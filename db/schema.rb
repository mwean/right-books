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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141125195718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "author"
    t.string   "cover_image"
    t.date     "publish_date"
    t.string   "slug",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "publisher"
    t.string   "amazon_link"
    t.text     "description"
    t.text     "editor_notes"
    t.integer  "category"
    t.string   "isbn"
  end

  add_index "books", ["category"], name: "index_books_on_category", using: :btree
  add_index "books", ["slug"], name: "index_books_on_slug", unique: true, using: :btree

end
