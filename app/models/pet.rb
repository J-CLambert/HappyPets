class Pet < ApplicationRecord
  belongs_to :user
  has_many :requests
  has_many_attached :photos
  validates :name, :photos, :price, :breed, :description, :title, :birthday, :vaccinated_against, :species, presence: true
  include PgSearch::Model
  multisearchable against: %i[name breed species description]
end
