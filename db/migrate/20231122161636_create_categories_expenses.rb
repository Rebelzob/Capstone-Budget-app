class CreateCategoriesExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :categories_expenses do |t|
      t.references :category, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true
    end
  end
end
