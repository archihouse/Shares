json.extract! company, :id, :name, :symbol, :price, :change, :changepercentage, :marketcap, :high, :low, :ytd, :industry, :exchange, :index, :country, :created_at, :updated_at
json.url company_url(company, format: :json)
