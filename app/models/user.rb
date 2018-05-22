class User < ApplicationRecord
  has_secure_password # uses bcrypt gem to secure password for customer security
  has_many :portfolios
  has_and_belongs_to_many :indices
  validates :email, :presence => true, :uniqueness => true # to validate email, check email is being submitted, check email is unique (no previous same email)
end
