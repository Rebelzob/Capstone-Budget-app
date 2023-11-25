require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'SplashControllers', type: :request do
  describe 'GET /' do
    before { visit root_path }

    it 'renders the splash/index view' do
      expect(page).to have_http_status(:success)
    end

    it 'click on the login button to being redirect to it' do
      click_link 'Login'
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'click on the sign up button to being redirect to it' do
      click_link 'Sign Up'
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end
