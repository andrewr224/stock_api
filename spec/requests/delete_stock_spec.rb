# frozen_string_literal: true

require "rails_helper"

describe "DELETE stock/:id", type: :request do
  let(:stock) { create(:stock) }

  before do
    delete v1_stock_path stock
  end

  it "returns created status" do
    expect(response).to have_http_status(:ok)
  end
end
