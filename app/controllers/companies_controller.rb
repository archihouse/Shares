require 'open-uri'

class CompaniesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @companies = Company.order(sort_column + ' ' + sort_direction)

    # Search/filter our database
    if params[:name]
      @companies = Company.where(name: params[:name])
    end

  end

  # GET /company/new
  def new
    @company = Company.new
  end

  def edit
  end

  def result
      symbol = params[:symbol]
      # find info with search parameters

      url = "https://api.iextrading.com/1.0/stock/#{symbol}/quote"
      data = JSON.parse(open(url).read)
        @name = data["companyName"]
        @symbol = data["symbol"]
        @price = data["latestPrice"]
        @change = data["change"]
        @changepercentage = data["changePercent"] * 100
        @marketcap = data["marketCap"]
        @high = data["week52High"]
        @low = data["week52Low"]
        @ytd = data["ytdChange"] * 100
        @exchange = data["primaryExchange"]
        @sector = data["sector"]
      # return companies
      list = Company.where("companyName" => @name)
        # redirect them to the show page for that company so they can add that company to the database from there
          @company = Company.create(:name => @name, :symbol => @symbol, :price => @price, :change => @change, :changepercentage => @changepercentage, :marketcap => @marketcap, :high => @high, :low => @low, :ytd => @ytd,
            :exchange => @exchange, :sector => @sector)
      end

    def hk_result
      symbol = params[:symbol]

      url = "https://www.quandl.com/api/v3/datasets/HKEX/#{symbol}?api_key=6xsfYj8mVfS1YxxVN5Dt"
      data = JSON.parse(open(url).read)
        @name = data["dataset"]["name"]
        @symbol = data["dataset"]["dataset_code"]
        @price = data["dataset"]["data"][2]
        @change = data["dataset"]["data"][3]
        @changepercentage = data["dataset"]["data"][4]
        @marketcap = data["dataset"]["data"][2] * data["dataset"]["data"][11]
      # return companies
      list = Company.where("name" => @name)
        # redirect them to the show page for that company so they can add that company to the database from there
          @company = Company.create(:name => @name, :symbol => @symbol, :price => @price, :change => @change, :changepercentage => @changepercentage, :marketcap => @marketcap, :exchange => @exchange)
      end

    # POST /companies
    # POST /companies.json
    def create
      @company = Company.new(company_params)

      respond_to do |format|
        if @company.save
          format.html { redirect_to @company, notice: 'Stock Info Created.' }
          format.json { render :show, status: :created, location: @company }
        else
          format.html { render :new }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /companies/1
    # PATCH/PUT /companies/1.json
    def update
      respond_to do |format|
        if @company.update(company_params)
          format.html { redirect_to @company, notice: 'Stock Info Updated.' }
          format.json { render :show, status: :ok, location: @company }
        else
          format.html { render :edit }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end

    def self.perform
      data = read_from_api
      save(data)
    end

    def read_from_api
      # ...
    end

    def save(data)
      # save to db
    end

    # DELETE /companies/1
    # DELETE /companies/1.json
    def destroy
      company = Company.find params[:id]
      company.destroy
      respond_to do |format|
        format.html { redirect_to companies_url, notice: 'Company Deleted.' }
        format.json { head :no_content }
      end
    end

    def show
      @company = Company.find params[:id]
    end

  private
      # Use callbacks to share common setup or constraints between actions.
      def set_company
        @company = Company.find(params[:id])
      end

      def company_params
        params.require(:company).permit(:name, :symbol, :price, :change, :changepercentage, :marketcap, :high, :low, :ytd, :exchange, :sector)
      end

      def sort_column
        Company.column_names.include?(params[:sort]) ? params[:sort] : "name"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
      end
  end
