# frozen_string_literal: true

require "rails_helper"

describe Stocks::Create do
  subject(:result) { described_class.call(context) }

  let(:context) do
    {
      params: stock_attrs,
      bearer: bearer
    }
  end

  let(:bearer)      { create(:bearer) }
  let(:stock_attrs) { attributes_for(:stock) }

  it "is successful" do
    expect(result).to be_success
  end

  it "creates a new stock for the bearer" do
    expect { result }.to change(bearer.stocks, :count).by(1)
  end

  context "with invalid attributes" do
    let!(:existing_stock) { create(:stock) }
    let(:stock_attrs)     { attributes_for(:stock).merge(name: existing_stock.name) }

    it "is a failure" do
      expect(result).to be_failure
    end

    it "doesn't create a new stock" do
      expect { result }.not_to change(Stock, :count)
    end

    it "returns errors" do
      expect(result.errors.attribute_names).to include(:name)
    end
  end
end
