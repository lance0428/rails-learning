json.extract! transaction, :id, :debit_account_id, :credit_account_id, :description, :amount, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
