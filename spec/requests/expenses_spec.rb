require 'rails_helper'

RSpec.describe 'ExpensesControllers', type: :request do
  before do
    @user = User.find_or_create_by(name: 'John', email: 'johndoe@example.com') do |user|
      user.password = '123456'
    end
    @category = Category.find_or_create_by(user: @user, name: 'Microverse') do |category|
      category.icon = 'microverse.png'
    end
    visit new_user_session_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'Log in'
  end

  describe 'GET #new' do
    it 'renders the add a new expense page' do
      visit new_category_expense_path(@category)
      expect(page).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new transaction' do
      visit new_category_expense_path(@category)

      fill_in 'name', with: 'Expense'
      fill_in 'amount', with: 50.00

      click_button 'Save'

      expect(page).to have_current_path(category_path(@category))
    end
  end
end
