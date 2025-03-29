# frozen_string_literal: true

RSpec.describe Hodlhodl::UseCases::Transactions::CalculateFees do
  subject(:use_case) { described_class.new }

  describe "#call" do
    let(:amount_btc) { 0.01 }
    let(:exchange_fee_percent) { Hodlhodl::Config::Transaction::EXCHANGE_FEE_PERCENT }
    let(:network_fee) { Hodlhodl::Config::Transaction.network_fee }

    it "returns correct exchange fee, network fee, and estimated BTC" do
      expected_exchange_fee = (amount_btc * exchange_fee_percent).round(8)
      expected_estimated_btc = (amount_btc - expected_exchange_fee - network_fee).round(8)

      result = use_case.call(amount_btc: amount_btc)

      expect(result).to eq(
        exchange_fee_btc: expected_exchange_fee,
        network_fee_btc: network_fee,
        estimated_btc: expected_estimated_btc
      )
    end

    context "when amount_btc is very small" do
      let(:amount_btc) { 0.00001 }

      it "still returns valid fee values" do
        result = use_case.call(amount_btc: amount_btc)

        expect(result[:exchange_fee_btc]).to be > 0
        expect(result[:network_fee_btc]).to eq(network_fee)
        expect(result[:estimated_btc]).to be < amount_btc
      end
    end
  end
end
