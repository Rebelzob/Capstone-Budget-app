class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[new create]
  before_action :set_user, only: %i[new create]

  def new
    @expense = Expense.new
  end

  def create
    @expense = @user.expenses.build(expense_params)
    @expense.author_id = current_user.id
    @category.expenses << @expense

    if @expense.save
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  private

  def set_expense
    @expense = Expense.find_by(id: params[:id])
  end

  def set_user
    @user = current_user
  end

  def expense_params
    params.require(:expense).permit(:amount, :category_id)
  end
end
