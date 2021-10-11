# frozen_string_literal: true

require "rails_helper"

describe "PATCH /stock", type: :request do
  let(:params) do
    { stock: stock_attrs }
  end

  let(:stock)       { create(:stock) }
  let(:stock_attrs) { attributes_for(:stock) }

  before do
    patch v1_stock_path stock, params: params
  end

  it "returns created status" do
    expect(response).to have_http_status(:ok)
  end

  it "returns stock info" do
    expect(response_body.dig(:data, :attributes, :name)).to eq(stock_attrs[:name])
  end

  context "with invalid params" do
    let(:stock_attrs) { attributes_for(:stock).merge(name: "") }

    it "returns bad_request status" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns errors" do
      expect(response_body[:errors].first[:detail]).to eq("can't be blank")
    end
  end
end
