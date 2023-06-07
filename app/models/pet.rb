class Pet < ApplicationRecord
  belongs_to :user
  validates :name, :price, :breed, :description, :title, :birthday, :vaccinated_against, :species, presence: true
  include PgSearch::Model
  multisearchable against: %i[name breed species description]
end
