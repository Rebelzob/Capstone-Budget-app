require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/expenses/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/expenses/create'
      expect(response).to have_http_status(:success)
    end
  end
end
