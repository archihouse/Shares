class CreateCompaniesIndices < ActiveRecord::Migration[5.1]
  def change
    create_table :companies_indices, :id => false do |t|
      t.integer :company_id
      t.integer :index_id
    end
  end
end
