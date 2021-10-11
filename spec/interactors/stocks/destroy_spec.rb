# frozen_string_literal: true

require "rails_helper"

describe Stocks::Destroy do
  subject(:result) { described_class.call(context) }

  let(:context) do
    { stock: stock }
  end

  let(:stock) { create(:stock) }

  it "is successful" do
    expect(result).to be_success
  end

  it "discards the stock" do
    expect { result }.to change(stock, :discarded?).from(false).to(true)
  end
end
