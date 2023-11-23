class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses

  validate :name, presence: true, uniqueness: true
  validate :icon, presence: true

  private

  def expenses_for_user(user)
    expenses.where(author_id: user.id)
  end
end
