class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :debit_account_id
      t.integer :credit_account_id
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end
end
