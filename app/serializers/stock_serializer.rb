# frozen_string_literal: true

class StockSerializer < ApplicationSerializer
  attribute :name
  attribute :corporation
  attribute :amount
  attribute :price

  belongs_to :bearer, serializer: BearerSerializer
end
