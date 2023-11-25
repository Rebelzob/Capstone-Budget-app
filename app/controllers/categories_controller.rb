class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show]

  def index
    @categories = current_user.categories.includes(:expenses)
    @expenses = @categories.flat_map { |category| category.expenses.to_a }.select { |expense| expense.author_id == current_user.id }
  end

  def show
    @expenses = @category.expenses.where(author_id: current_user.id).order(created_at: :desc)
    @total = @expenses.sum(&:amount)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)

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

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end