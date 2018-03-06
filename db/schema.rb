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

ActiveRecord::Schema.define(version: 20180122200003) do

  create_table "aa_inst", primary_key: "uniqueIdentifier", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "organizationName", limit: 128, null: false
    t.integer "manager"
    t.timestamp "lastModifiedTime", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "lastModifiedBy", limit: 64, null: false
    t.string "dlpsDeleted", limit: 1, null: false
  end

  create_table "aa_network", primary_key: "uniqueIdentifier", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "dlpsDNSName", limit: 128
    t.string "dlpsCIDRAddress", limit: 18
    t.bigint "dlpsAddressStart"
    t.bigint "dlpsAddressEnd"
    t.string "dlpsAccessSwitch", limit: 5, null: false
    t.string "coll", limit: 32
    t.integer "inst"
    t.timestamp "lastModifiedTime", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "lastModifiedBy", limit: 64, null: false
    t.string "dlpsDeleted", limit: 1, null: false
    t.index ["dlpsAddressEnd"], name: "network_dlpsAddressEnd_index"
    t.index ["dlpsAddressStart"], name: "network_dlpsAddressStart_index"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checkpoint_schema", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "version", default: 0, null: false
  end

  create_table "keycard_schema", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "version", default: 0, null: false
  end

  create_table "listings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "body"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_listings_on_category_id"
    t.index ["owner_id"], name: "index_listings_on_owner_id"
  end

  create_table "permits", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "agent_type", limit: 100, null: false
    t.string "agent_id", limit: 100, null: false
    t.string "agent_token", limit: 201, null: false
    t.string "credential_type", limit: 100, null: false
    t.string "credential_id", limit: 100, null: false
    t.string "credential_token", limit: 201, null: false
    t.string "resource_type", limit: 100, null: false
    t.string "resource_id", limit: 100, null: false
    t.string "resource_token", limit: 201, null: false
    t.string "zone_id", limit: 100, null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username"
    t.string "display_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "listings", "users", column: "owner_id"
end
