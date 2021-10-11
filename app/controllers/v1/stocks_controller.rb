# frozen_string_literal: true

module V1
  class StocksController < ApplicationController
    before_action :find_stock, only: :update

    def create
      result = Stocks::CreateOrganizer.call(params: stock_params)

      return respond_with_errors(result.errors) if result.failure?

      json_response StockSerializer.new(result.stock), status: :created
    end

    def update
      result = Stocks::Update.call(stock: @stock, params: update_params)

      return respond_with_errors(result.errors) if result.failure?

      json_response StockSerializer.new(result.stock), status: :ok
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

    def json_response(serializer, status: :ok)
      render json: serializer, status: status
    end

    def respond_with_errors(errors)
      render json:   { errors: ErrorSerializer.new(errors).serialized_json },
             status: :unprocessable_entity
    end

    def find_stock
      @stock = Stock.find(params[:id])
    end
  end
end
