class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show]
  before_action :set_user, only: %i[index show create]

  def index
    @categories = @user.categories.includes(:expenses)
    @expenses = @categories.flat_map { |category| category.expenses_for_user(current_user) }
  end

  def show
    @expenses = @category.expenses_for_user(current_user).includes(:category)
    @total = @expenses.sum(:amount)
  end

  def new
    @category = Category.new
  end

  def create
    @category = @user.categories.build(category_params)

    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def set_user
    @user = current_user
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
