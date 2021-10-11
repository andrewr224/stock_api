# frozen_string_literal: true

require "rails_helper"

describe Stocks::Update do
  subject(:result) { described_class.call(context) }

  let(:context) do
    {
      stock:  stock,
      params: stock_attrs
    }
  end

  let(:stock)       { create(:stock) }
  let(:stock_attrs) { attributes_for(:stock) }

  it "is successful" do
    expect(result).to be_success
  end

  it "updates stock attributes" do
    expect { result }.to change(stock, :name).to(stock_attrs[:name])
  end

  context "with invalid attributes" do
    let!(:existing_stock) { create(:stock) }
    let(:stock_attrs)     { attributes_for(:stock).merge(name: existing_stock.name) }

    it "is a failure" do
      expect(result).to be_failure
    end

    it "doesn't update stock attributes" do
      expect { result; stock.reload }.not_to change(stock, :name)
    end

    it "returns errors" do
      expect(result.errors.attribute_names).to include(:name)
    end
  end
end
