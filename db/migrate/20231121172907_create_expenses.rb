class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.integer :author_id
      t.string :name
      t.decimal :amount

      t.timestamps
    end

    add_foreign_key :expenses, :users, column: :author_id
  end
end
