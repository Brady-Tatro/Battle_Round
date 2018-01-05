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

ActiveRecord::Schema.define(version: 20180105233126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.integer "attack_models",                      null: false
    t.integer "shots",                              null: false
    t.integer "ballistic_skill",                    null: false
    t.integer "weapon_strength",                    null: false
    t.integer "damage",                             null: false
    t.integer "ap_value",           default: 0,     null: false
    t.integer "defend_models",                      null: false
    t.integer "toughness",                          null: false
    t.integer "armour",                             null: false
    t.integer "invulnerable",       default: 0,     null: false
    t.integer "leadership",                         null: false
    t.integer "times_run",                          null: false
    t.string  "d3"
    t.string  "d6"
    t.string  "plasma"
    t.string  "always_hit"
    t.string  "sniper"
    t.string  "neg1_to_hit_attack"
    t.string  "neg1_to_hit_defend"
    t.string  "plus1_to_hit"
    t.string  "reroll_hits"
    t.string  "reroll1_hits"
    t.string  "reroll_wounds"
    t.string  "reroll1_wounds"
    t.integer "wounds",                             null: false
    t.integer "total_rounds",                                    array: true
    t.integer "died_to_plasma"
    t.boolean "saved",              default: false
    t.string  "d3_damage"
    t.string  "d6_damage"
  end

end
