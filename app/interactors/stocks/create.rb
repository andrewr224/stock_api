# frozen_string_literal: true

module Stocks
  class Create < ApplicationInteractor
    before { context.stock = stock }

    def call
      save

      return if stock.persisted?

      context.errors = stock.errors
      context.fail!
    end

    private

    delegate :bearer, to: :context, private: true

    def stock
      @stock ||= bearer.stocks.new(context.params)
    end

    def save
      ActiveRecord::Base.transaction do
        stock.save! if stock.valid?
      end
    end
  end
end
