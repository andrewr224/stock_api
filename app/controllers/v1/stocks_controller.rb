# frozen_string_literal: true

module V1
  class StocksController < ApplicationController
    before_action :find_bearer, only: :index
    before_action :find_stock,  only: %i[update destroy]

    def index
      json_response StockSerializer.new(@bearer.stocks.kept)
    end

    def create
      result = Stocks::CreateOrganizer.call(params: stock_params)

      return respond_with_errors(result.errors) if result.failure?

      json_response StockSerializer.new(result.stock), status: :created
    end

    def update
      result = Stocks::Update.call(stock: @stock, params: update_params)

      return respond_with_errors(result.errors) if result.failure?

      json_response StockSerializer.new(result.stock)
    end

    def destroy
      Stocks::Destroy.call(stock: @stock)

      head :ok
    end

    private

    def stock_params
      params
        .require(:stock)
        .permit(:amount, :price, :name, :corporation, :bearer_name)
    end

    def update_params
      stock_params.except(:bearer_name)
    end

    def find_stock
      @stock = Stock.find(params[:id])
    end

    def find_bearer
      @bearer = Bearer.find(params[:bearer_id])
    end
  end
end
