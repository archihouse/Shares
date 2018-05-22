class IndustriesController < ApplicationController
  def index
    @industries = Industry.all
  end

  def show
    @industry = Industry.find params[:id]
  end
end
