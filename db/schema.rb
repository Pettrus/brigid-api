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

ActiveRecord::Schema.define(version: 20181216220902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "uuid-ossp"

  create_table "eventos", force: :cascade do |t|
    t.string   "nome",        limit: 70, null: false
    t.float    "horas",                  null: false
    t.date     "competencia",            null: false
    t.uuid     "usuario_id",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["usuario_id"], name: "index_eventos_on_usuario_id", using: :btree
  end

  create_table "jornada_trabalhos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.date     "competencia", null: false
    t.datetime "inicio",      null: false
    t.datetime "fim"
    t.float    "horas"
    t.uuid     "usuario_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["usuario_id"], name: "index_jornada_trabalhos_on_usuario_id", using: :btree
  end

  create_table "usuarios", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "provider",                       default: "email", null: false
    t.string   "uid",                            default: "",      null: false
    t.string   "encrypted_password",             default: "",      null: false
    t.integer  "sign_in_count",                  default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "nome",               limit: 120,                   null: false
    t.string   "email",              limit: 120,                   null: false
    t.string   "avatar"
    t.float    "tempo_jornada",                  default: 8.0,     null: false
    t.float    "horas_extras",                   default: 0.0,     null: false
    t.json     "tokens"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "endpoint"
    t.string   "p256dh"
    t.string   "auth"
    t.index ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_usuarios_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "eventos", "usuarios"
  add_foreign_key "jornada_trabalhos", "usuarios"
end
