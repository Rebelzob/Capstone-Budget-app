require 'rails_helper'

RSpec.describe 'splash_screen/index', type: :view do
  it 'renders the logo' do
    render
    assert_select 'img[src^=?]', '/assets/logo-'
  end

  it 'renders the login link' do
    render

    assert_select 'a[href=?]', new_user_session_path
  end

  it 'renders the sign up link' do
    render

    assert_select 'a[href=?]', new_user_registration_path
  end
end
