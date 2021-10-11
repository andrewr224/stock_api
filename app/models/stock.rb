# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :bearer

  validates :name, presence: true, uniqueness: true

  validates :amount, :price, :corporation, presence: true
end
