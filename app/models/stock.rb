# frozen_string_literal: true

class Stock < ApplicationRecord
  include Discard::Model

  belongs_to :bearer

  validates :name, presence: true, uniqueness: true

  validates :amount, :price, :corporation, presence: true
end
