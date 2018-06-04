json.extract! company, :id, :name, :symbol, :price, :change, :changepercentage, :marketcap, :high, :low, :ytd, :sector, :exchange, :created_at, :updated_at
json.url company_url(company, format: :json)
