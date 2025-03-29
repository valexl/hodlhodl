# frozen_string_literal: true

RSpec.describe Hodlhodl::UseCases::Transactions::StartTransaction, :db do
  subject(:use_case) { described_class.new }

  let(:repo) { Hodlhodl::Repos::TransactionRepo.new }
  let(:rate) { 0.00002151 }
  let(:fees) do
    {
      exchange_fee_btc: 0.00001,
      network_fee_btc: 0.000006,
      estimated_btc: 0.00063
    }
  end

  let(:valid_attrs) do
    {
      amount_usdt: "30",
      wallet_address: "1BoatSLRHtKNngkdXEeobR76b53LETtpyT",
      email: "user@example.com",
      agree: "on"
    }
  end

  describe "#call" do
    context "with valid input" do
      it "creates a transaction and returns it" do
        result = use_case.call(attrs: valid_attrs, rate: rate, fees: fees)

        expect(result).to be_a(Dry::Monads::Result::Success)
        transaction = result.value!

        expect(transaction).to include(
          amount_usdt: 30,
          recipient_address: "1BoatSLRHtKNngkdXEeobR76b53LETtpyT",
          email: "user@example.com",
          exchange_fee_btc: fees[:exchange_fee_btc],
          network_fee_btc: fees[:network_fee_btc],
          estimated_btc: fees[:estimated_btc],
          rate_btc: rate
        )

        db_tx = repo.find_by_uid(transaction[:uid])
        expect(db_tx).not_to be_nil
      end
    end

    context "with invalid input" do
      it "returns error hash with messages" do
        invalid_attrs = valid_attrs.merge(email: "", agree: nil)

        result = use_case.call(attrs: invalid_attrs, rate: rate, fees: fees)

        expect(result).to be_a(Dry::Monads::Result::Failure)
        expect(result.failure).to include(
          email: "email is required",
          agree: "must be accepted"
        )
      end
    end
  end
end
