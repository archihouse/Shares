class CreateCompaniesPortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :companies_portfolios, :id => false do |t|
      t.integer :company_id
      t.integer :portfolio_id
    end
  end
end
