# frozen_string_literal: true

class Bearer < ApplicationRecord
  has_many :stocks, inverse_of: :bearer, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
