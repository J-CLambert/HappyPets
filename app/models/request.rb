class Request < ApplicationRecord
  belongs_to :pet
  belongs_to :user

  enum status: { pending_visit: 0, confirmed_visit: 1, refused: 2, transaction_accepted: 3 }
  validates :visit_date, presence: true
end
