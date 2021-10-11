# frozen_string_literal: true

module Bearers
  class FindOrInitialize < ApplicationInteractor
    def call
      context.bearer = bearer
    end

    private

    def bearer
      Bearer.find_or_initialize_by(name: name)
    end

    def name
      context.params.delete(:bearer)
    end
  end
end
