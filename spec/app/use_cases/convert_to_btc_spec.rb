# frozen_string_literal: true

RSpec.describe Hodlhodl::UseCases::Transactions::ConvertToBtc do
  subject(:use_case) { described_class.new }

  it "converts USDT to BTC using the provided rate" do
    expect(use_case.call(amount_usdt: 100.0, rate: 0.00002)).to eq(0.002)
  end

  it "returns 0.0 for zero amount" do
    expect(use_case.call(amount_usdt: 0, rate: 0.00002)).to eq(0.0)
  end

  it "rounds to 8 decimal places" do
    result = use_case.call(amount_usdt: 1, rate: 0.000021515151)
    expect(result).to eq(0.00002152)
  end
end
