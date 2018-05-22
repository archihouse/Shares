class IndicesController < ApplicationController
  def index
    @indices = Index.all
  end

  def show
    @index = Index.find params[:id]
  end
end
