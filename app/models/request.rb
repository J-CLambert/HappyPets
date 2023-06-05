class Request < ApplicationRecord
  belongs_to :pet
  belongs_to :user

  enum status: { pending_visit: 0, confirmed_visit: 1, transaction_accepted: 2, ready_for_pick_up: 3 }
  validates :visit_date, presence: true
end
create_table "requests", force: :cascade do |t|
  t.text "message"
  t.string "title"
  t.datetime "visit_date"
  t.bigint "pet_id", null: false
  t.bigint "user_id", null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.integer "status", default: 0
  t.index ["pet_id"], name: "index_requests_on_pet_id"
  t.index ["user_id"], name: "index_requests_on_user_id"
end
