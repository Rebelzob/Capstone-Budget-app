require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create(name: 'Peter Tong', email: 'petertong@example.com', password: '123456') }
  let(:category) { Category.create(user: user, name: 'Commerce', icon: 'icon.jpg') }
  let(:expense) { category.expenses.build(author_id: user.id, name: 'fries', amount: 30.58) }

  it 'is valid with valid attributes' do
    expect(expense).to be_valid
  end

  it 'is not valid without a user' do
    expense.author_id = nil
    expect(expense).to be_invalid
  end

  it 'is not valid without a name' do
    expense.name = nil
    expect(expense).to be_invalid
  end

  it 'has and belongs to a user' do
    association = Expense.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'has and belongs to many categories' do
    association = Expense.reflect_on_association(:categories)
    expect(association.macro).to eq(:has_and_belongs_to_many)
  end

  it 'is not valid without an amount' do
    expense.amount = nil
    expect(expense).to be_invalid
  end
  
  it 'is not valid if the amount is not a number' do
    expense.amount = 'thirty'
    expect(expense).to be_invalid
  end
  
  it 'is not valid if the amount is less than or equal to zero' do
    expense.amount = 0
    expect(expense).to be_invalid
  end
end