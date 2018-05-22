class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    portfolio = Portfolio.create portfolio_params
    redirect_to portfolio # /portfolios/:some_id ie. the show page
  end

  def edit
    @portfolio = Portfolio.find params[:id]
  end

  def update
    portfolio = Portfolio.find params[:id]
    portfolio.update portfolio_params
    redirect_to portfolio
  end

  def destroy
    portfolio = Portfolio.find params[:id]
    portfolio.destroy
    redirect_to portfolios_path
  end

  def show
    @portfolio = Portfolio.find params[:id]
  end
end
