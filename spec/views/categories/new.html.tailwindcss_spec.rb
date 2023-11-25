require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  let(:user) do
    User.find_or_create_by(name: 'John', email: 'johndoe@example.com') do |user|
      user.password = '123456'
    end
  end

  before do
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'
    visit new_category_path
  end

  scenario 'displays the new category form' do
    expect(page).to have_content('New Category')
    expect(page).to have_selector("input[placeholder='Name']")
    expect(page).to have_selector("input[placeholder='Icon (URL)']")
    expect(page).to have_button('Save')
  end

  scenario 'creates a new category when form is submitted' do
    fill_in 'category_name', with: 'New Category'
    fill_in 'category_icon', with: 'new_icon.png'
    click_button 'Save'
  
    expect(page).to have_content('New Category')
    expect(Category.where(name: 'New Category', icon: 'new_icon.png')).to exist
  end
end