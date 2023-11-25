class ExpensesController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :set_category, only: %i[new create]

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.author_id = current_user.id
    @category.expenses << @expense

    if @expense.save!
      redirect_to category_path(@category)
    else
      render :new, alert: 'Something went wrong'
    end
  end

  private

  def set_category
    @category = @user.categories.find(params[:category_id])
  end

  def set_user
    @user = current_user
  end

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
