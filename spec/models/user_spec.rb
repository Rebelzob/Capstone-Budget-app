require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'John Doe', email: 'john@example.com', password: '123456') }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to be_invalid
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).to be_invalid
  end

  it 'has many expenses' do
    association = User.reflect_on_association(:expenses)
    expect(association.macro).to eq(:has_many)
  end

  it 'requires a unique email' do
    User.create(name: 'Existing User', email: 'existing@example.com', password: '123456')
    new_user = User.new(name: 'New User', email: 'existing@example.com', password: '123456')
    expect(new_user).to be_invalid
  end

  it 'password must have at least 6 characters' do
    user.password = '12345'
    expect(user).to be_invalid
  end

  # Additional tests
  it 'is not valid without a password' do
    user.password = nil
    expect(user).to be_invalid
  end

  it 'has many categories' do
    association = User.reflect_on_association(:categories)
    expect(association.macro).to eq(:has_many)
  end

  it 'has many expenses' do
    association = User.reflect_on_association(:expenses)
    expect(association.macro).to eq(:has_many)
  end
end
