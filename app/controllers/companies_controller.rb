class CompaniesController < ApplicationController
  def index
    @companies = Company.all

    # Search/filter our database
    if params[:name]
      @companies = Company.where(name: params[:name])
    end

  end

  def show
  end

  # GET /company/new
  def new
    @company = Company.new
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
      # return companies
      list = Company.where("companyName" => @name)
        # redirect them to the show page for that company so they can add that company to the database from there
          @company = Company.create(:name => @name, :symbol => @symbol, :price => @price, :change => @change, :changepercentage => @changepercentage, :marketcap => @marketcap, :high => @high, :low => @low, :ytd => @ytd,
            :exchange => @exchange)
      end

    def hk_result
      symbol = params[:symbol]

      url = "https://www.quandl.com/api/v3/datasets/HKEX/#{symbol}?api_key=6xsfYj8mVfS1YxxVN5Dt"
      data = JSON.parse(open(url).read)
        @name = data["dataset"]["name"]
        @symbol = data["dataset"]["dataset_code"]
        @price = data["dataset"]["data"][0]
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

    # DELETE /companies/1
    # DELETE /companies/1.json
    def destroy
      @company.destroy
      respond_to do |format|
        format.html { redirect_to companies_url, notice: 'Company Deleted.' }
        format.json { head :no_content }
      end
    end

  private
      # Use callbacks to share common setup or constraints between actions.
      def set_company
        @company = Company.find(params[:id])
      end

      def company_params
      params.require(:company).permit(:name, :symbol, :price, :change, :changepercentage, :marketcap, :high, :low, :ytd, :exchange, :index, :country)
      end
  end
