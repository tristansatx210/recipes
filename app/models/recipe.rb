class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 25, maximum: 500 }
  belongs_to :chef
  validates :chef_id, presence: true
end