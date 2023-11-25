require 'rails_helper'

RSpec.describe 'CategoriesControllers', type: :request do
  describe 'GET /categories' do
    before do
      @user = User.find_or_create_by(name: 'Peter', email: 'petertong@example.com') do |user|
        user.password = '123456'
      end
      @category = Category.find_or_create_by(user: @user, name: 'Commerce') do |category|
        category.icon = 'commerce.png'
      end
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'Log in'
    end

    it 'renders the categories/index view' do
      visit categories_path
      expect(page).to have_http_status(:success)
    end

    it 'renders a list with the categories of the user' do
      expect(page).to have_content('Commerce')
    end

    it 'renders a button to add a new category' do
      expect(page).to have_link('Add a New Category')
    end

    it 'clicks on the add a new category button to create a new one' do
      click_link 'Add a New Category'
      expect(page).to have_current_path(new_category_path)
    end

    it 'clicks on the logout button to exit from the application' do
      click_button 'Log Out'
      expect(page).to have_current_path(root_path)
    end
  end
end
