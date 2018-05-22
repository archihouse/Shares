class CreateCompaniesExchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :companies_exchanges, :id => false do |t|
      t.integer :company_id
      t.integer :exchange_id
    end
  end
end
