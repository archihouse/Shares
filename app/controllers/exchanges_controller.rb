def exchange
  @exchanges = Exchange.all
end

def new
  @exchange = Exchange.new
end
