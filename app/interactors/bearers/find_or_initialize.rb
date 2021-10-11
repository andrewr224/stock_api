# frozen_string_literal: true

module Bearers
  class FindOrInitialize < ApplicationInteractor
    def call
      context.bearer = bearer

      return if bearer.persisted? || bearer.valid?

      add_bearer_name_error
      context.fail!
    end

    private

    def bearer
      @bearer ||= Bearer.find_or_initialize_by(name: name)
    end

    def name
      context.params.delete(:bearer_name)
    end

    def add_bearer_name_error
      bearer.errors.clear
      bearer.errors.add(:bearer_name, "can't be blank")
      context.errors = bearer.errors
    end
  end
end
