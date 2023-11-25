require 'rails_helper'

RSpec.describe 'expenses/new', type: :view do
  let(:user) do
    User.create!(name: 'John', email: 'test@example.com', password: 'password') # Add necessary attributes here
  end

  let(:category) do
    Category.create!(name: 'Test Category', icon: 'test_icon.png', user:) # Associate the user with the category
  end

  before(:each) do
    assign(:category, category)
    assign(:expense, Expense.new)
  end

  it 'renders the form for creating a new expense' do
    render

    assert_select 'form[action=?][method=?]', category_expenses_path(category), 'post' do
      assert_select 'input[name=?]', 'expense[name]'
      assert_select 'input[name=?]', 'expense[amount]'
    end
  end

  it 'renders the back link' do
    render

    assert_select 'a[href=?]', category_path(category)
  end

  it 'renders the header' do
    render

    assert_select 'h1', text: 'New Transaction'
  end
end
