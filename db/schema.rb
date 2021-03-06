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

ActiveRecord::Schema.define(:version => 20110408040441) do

  create_table "affiliations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commenter_id"
    t.integer  "link_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["link_id"], :name => "index_comments_on_link_id"

  create_table "links", :force => true do |t|
    t.string   "url"
    t.string   "headline"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

  add_index "links", ["score"], :name => "index_links_on_score"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "affiliation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.text     "about"
    t.string   "location"
    t.string   "job"
    t.string   "company"
    t.string   "college"
    t.string   "blog"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linked_in"
    t.string   "personal_site"
    t.boolean  "email_private"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "voter_id"
    t.integer  "votable_id"
    t.integer  "direction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "votable_type"
  end

  add_index "votes", ["votable_id"], :name => "index_votes_on_link_id"
  add_index "votes", ["voter_id", "votable_id"], :name => "index_votes_on_voter_id_and_link_id", :unique => true
  add_index "votes", ["voter_id"], :name => "index_votes_on_voter_id"

end
