class Company < ApplicationRecord
  belongs_to :industry, :optional => true
  has_and_belongs_to_many :exchanges
  has_and_belongs_to_many :indices
  has_and_belongs_to_many :portfolios
end
