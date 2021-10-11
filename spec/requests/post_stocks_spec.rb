# frozen_string_literal: true

require "rails_helper"

describe "POST /stocks", type: :request do
  let(:params) do
    { stock: stock_attrs.merge(bearer: bearer_name) }
  end

  let(:stock_attrs) { attributes_for(:stock) }
  let(:bearer_name) { attributes_for(:bearer)[:name] }

  before do
    post v1_stocks_path, params: params
  end

  it "returns created status" do
    expect(response).to have_http_status(:created)
  end

  it "returns stock info" do
    expect(response_body.dig(:data, :attributes, :name)).to eq(stock_attrs[:name])
  end

  context "with invalid params" do
    let(:stock_attrs) { attributes_for(:stock).except(:name) }

    it "returns bad_request status" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns errors" do
      expect(response_body[:errors].first[:detail]).to eq("can't be blank")
    end
  end

  context "when stock already exists" do
    let(:existing_stock) { create(:stock) }
    let(:stock_attrs)    { attributes_for(:stock).merge(name: existing_stock.name) }

    it "returns bad_request status" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns errors" do
      expect(response_body[:errors].first[:detail]).to eq("has already been taken")
    end
  end
end
