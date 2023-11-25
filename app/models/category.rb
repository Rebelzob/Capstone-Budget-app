class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses, foreign_key: :category_id, dependent: :destroy

  validates :name, presence: true
  validates :icon, presence: true
end
