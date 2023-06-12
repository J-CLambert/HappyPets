class Message < ApplicationRecord
  belongs_to :messenger
  belongs_to :user
end
