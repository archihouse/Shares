class IndicesController < ApplicationController
  def index
    @indices = Index.all
  end

  def new
    @index = Index.new
  end

  def create
    index = Index.create index_params
    redirect_to index
  end

  def edit
    @index = Index.find params[:id]
  end

  def update
    index = Index.find params[:id]
    index.update index_params
    redirect_to index
  end

  def destroy
    index = Index.find params[:id]
    index.destroy
    redirect_to indices_path
  end

  def show
    @index = Index.find params[:id]
  end

  private
  def index_params
    params.require(:index).permit(:name)
  end
end
