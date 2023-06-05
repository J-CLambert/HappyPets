class Request < ApplicationRecord
  belongs_to :pet
  belongs_to :user

  enum status: { pending_visit: 0, confirmed_visit: 1, transaction_accepted: 2, ready_for_pick_up: 3 }
  validates :visit_date, presence: true
end
