# frozen_string_literal: true

require "rails_helper"

describe Stocks::CreateOrganizer do
  subject(:result) { described_class.call(context) }

  let(:context) do
    { params: stock_attrs.merge(bearer_name: bearer_name) }
  end

  let(:stock_attrs) { attributes_for(:stock) }
  let(:bearer_name) { attributes_for(:bearer)[:name] }

  it "is successful" do
    expect(result).to be_success
  end

  it "creates a new stock" do
    expect { result }.to change(Stock, :count).by(1)
  end

  it "creates a new bearer" do
    expect { result }.to change(Bearer, :count).by(1)
  end

  context "when the bearer already exists" do
    let!(:existing_bearer) { create(:bearer) }
    let(:bearer_name)      { existing_bearer.name }

    it "doesn't create a new bearer" do
      expect { result }.not_to change(Bearer, :count)
    end

    it "creates a new stock for the bearer" do
      expect { result }.to change(existing_bearer.stocks, :count).by(1)
    end
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
