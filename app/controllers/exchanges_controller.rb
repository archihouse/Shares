require 'open-uri'

class ExchangesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @exchanges = Exchange.order(sort_column + ' ' + sort_direction)

    # Search/filter our database
    if params[:name]
      @exchanges = Exchange.where(name: params[:name])
    end

  end

  def new
    @exchange = Exchange.new
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
        @sector = data["sector"]

      list = Exchange.where("exchangeName" => @name)

          @exchange = Exchange.create(:name => @name, :symbol => @symbol, :price => @price, :change => @change, :changepercentage => @changepercentage, :marketcap => @marketcap, :high => @high, :low => @low, :ytd => @ytd,
            :sector => @sector)
      end

    def create
      @exchange = Exchange.new(exchange_params)

      respond_to do |format|
        if @exchange.save
          format.html { redirect_to @exchange, notice: 'Exchange Info Created.' }
          format.json { render :show, status: :created, location: @exchange }
        else
          format.html { render :new }
          format.json { render json: @exchange.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @exchange.update(company_params)
          format.html { redirect_to @exchange, notice: 'Stock Info Updated.' }
          format.json { render :show, status: :ok, location: @exchange }
        else
          format.html { render :edit }
          format.json { render json: @exchange.errors, status: :unprocessable_entity }
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

    def destroy
      company = Exchange.find params[:id]
      exchange.destroy
      respond_to do |format|
        format.html { redirect_to companies_url, notice: 'Exchange Deleted.' }
        format.json { head :no_content }
      end
    end

    def show
      @exchange = Exchange.find params[:id]
    end

  private
      # Use callbacks to share common setup or constraints between actions.
      def set_exchange
        @exchange = Exchange.find(params[:id])
      end

      def exchange_params
        params.require(:exchange).permit(:name, :symbol, :price, :change, :changepercentage, :marketcap, :high, :low, :ytd, :index_id, :sector)
      end

      def sort_column
        Exchange.column_names.include?(params[:sort]) ? params[:sort] : "name"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
      end
  end
