# frozen_string_literal: true

require "rails_helper"

describe "GET bearer/:id/stocks", type: :request do
  let(:bearer)         { create(:bearer) }
  let(:count)          { rand(1..3) }
  let(:controll_count) { rand(1..3) }

  before do
    create_list(:stock, count, bearer: bearer)
    create_list(:stock, controll_count, :discarded, bearer: bearer)

    get v1_bearer_stocks_path(bearer)
  end

  it "returns created status" do
    expect(response).to have_http_status(:ok)
  end

  it "returns a list of kept bearer stocks" do
    expect(response_body[:data].count).to eq(count)
  end
end
