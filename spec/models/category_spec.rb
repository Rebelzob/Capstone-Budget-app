require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(name: 'Peter Tong', email: 'petertong@example.com', password: '123456') }
  let(:category) { user.categories.build(name: 'Commerce', icon: 'icon.jpg') }

  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category.name = nil
    expect(category).to be_invalid
  end

  it 'is not valid without an icon' do
    category.icon = nil
    expect(category).to be_invalid
  end

  it 'has and belongs to many expenses ' do
    association = Category.reflect_on_association(:expenses)
    expect(association.macro).to eq(:has_and_belongs_to_many)
  end

  it 'belongs to a user' do
    association = Category.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'is not valid without a user' do
    category.user = nil
    expect(category).to be_invalid
  end
end