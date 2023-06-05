class Pet < ApplicationRecord
  belongs_to :user
  validates :name, :price, :breed, :description, :title, :birthday, :vaccinated_against, :species, presence: true
end
