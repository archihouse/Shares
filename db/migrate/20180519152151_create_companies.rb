class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :symbol
      t.string :country
      t.numeric :price
      t.numeric :change
      t.numeric :changepercentage
      t.numeric :marketcap
      t.numeric :high
      t.numeric :low
      t.numeric :ytd
      t.string :sector
      t.string :exchange
      t.numeric :industry_id
      t.timestamps
    end
  end
end
