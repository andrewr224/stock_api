# frozen_string_literal: true

module Stocks
  class Destroy < ApplicationInteractor
    def call
      stock.discard
    end

    delegate :stock, to: :context, private: true
  end
end
