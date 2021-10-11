# frozen_string_literal: true

module Stocks
  class CreateOrganizer < ApplicationOrganizer
    organize Bearers::FindOrInitialize, Stocks::Create
  end
end
