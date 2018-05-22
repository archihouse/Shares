User.destroy_all
u1 = User.create :email => 'jack@gmail.com'
u2 = User.create :email => 'jackie@gmail.com'

Company.destroy_all
c1 = Company.create :name => 'Apple'
c2 = Company.create :name => 'Amazon'
c3 = Company.create :name => 'Berkshire Hathaway'
c4 = Company.create :name => 'ExxonMobil'
c5 = Company.create :name => 'JP Morgan Chase'
c6 = Company.create :name => 'Johnson & Johnson'
c7 = Company.create :name => 'Tencent'

Portfolio.destroy_all
p1 = Portfolio.create :name => 'Retirement'
p2 = Portfolio.create :name => 'Savings'
p3 = Portfolio.create :name => 'College Fund'

Index.destroy_all
i1 = Index.create :name => 'S&P 500 Index'
i2 = Index.create :name => 'Dow Jones Index'
i3 = Index.create :name => 'Hang Seng Index'

Industry.destroy_all
id1 = Industry.create :name => 'Technology'
id2 = Industry.create :name => 'Conglomerates'
id3 = Industry.create :name => 'Energy'
id4 = Industry.create :name => 'Finance'
id5 = Industry.create :name => 'Consumer Goods'

Exchange.destroy_all
e1 = Exchange.create :name => 'New York Stock Exchange'
e2 = Exchange.create :name => 'NASDAQ'
e3 = Exchange.create :name => 'Hong Kong Stock Exchange'

# Companies within Portfolios
p1.companies << c1
p2.companies << c2
p3.companies << c3

# Companies within Indexes
i1.companies << c1 << c2 << c3 << c4 << c5 << c6
i2.companies << c1 << c4 << c5 << c6
i3.companies << c7

# Companies within Industries
id1.companies << c1 << c2 << c7
id2.companies << c3
id3.companies << c4
id4.companies << c5
id5.companies << c6

# Companies within Exchanges
e1.companies << c3 << c4 << c5 << c6
e2.companies << c1 << c2
e3.companies << c7

# Portfolios within Users

u1.portfolios << p1 << p2
u2.portfolios << p3

# Indexes within Users

u1.indices << i1 << i2
u2.indices << i3
