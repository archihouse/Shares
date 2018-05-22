class ExchangesController < ApplicationController
  def index
    @exchanges = Exchange.all
  end

  def show
    @exchange = Exchange.find params[:id]
  end
end
