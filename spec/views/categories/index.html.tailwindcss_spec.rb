require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  let(:user) do
    User.find_or_create_by(name: 'John', email: 'johndoe@example.com') do |user|
      user.password = '123456'
    end
  end

  let(:category) do
    Category.find_or_create_by(user: user, name: 'Microverse') do |category|
      category.icon = 'microverse.png'
    end
  end

  before do
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'
    category
    visit categories_path
  end

  scenario 'displays the categories of the user' do
    expect(page).to have_content(category.name)
  end

  scenario 'displays the total amount of each category' do
    expect(page).to have_content(ActionController::Base.helpers.number_to_currency(category.expenses.sum(&:amount), precision: 2))
  end

  scenario 'has a link to add a new category' do
    expect(page).to have_link('Add a New Category', href: new_category_path)
  end

  scenario 'has a link to each category' do
    expect(page).to have_link(category.name, href: category_path(category))
  end
end