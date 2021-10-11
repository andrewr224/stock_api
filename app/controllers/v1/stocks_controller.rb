# frozen_string_literal: true

module V1
  class StocksController < ApplicationController
    def create
      result = Stocks::CreateOrganizer.call(params: stock_params)

      return respond_with_errors(result.errors) if result.failure?

      json_response StockSerializer.new(result.stock), status: :created
    end

    private

    def stock_params
      params
        .require(:stock)
        .permit(:amount, :price, :name, :corporation, :bearer)
    end

    def json_response(serializer, status: :ok)
      render json: serializer, status: status
    end

    def respond_with_errors(errors)
      render json:   { errors: ErrorSerializer.new(errors).serialized_json },
             status: :unprocessable_entity
    end
  end
end
