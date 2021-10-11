# frozen_string_literal: true

module Stocks
  class Update < ApplicationInteractor
    def call
      return if stock.update(context.params)

      context.errors = stock.errors
      context.fail!
    end

    delegate :stock, to: :context, private: true
  end
end
