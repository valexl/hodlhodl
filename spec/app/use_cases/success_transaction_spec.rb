# frozen_string_literal: true

RSpec.describe Hodlhodl::UseCases::Transactions::SuccessTransaction, :db do
  describe "#call" do
    subject(:call) { described_class.new.call(transaction: transaction, txid: txid) }

    let(:repo) { Hodlhodl::Repos::TransactionRepo.new }
    let(:txid) { "abcd1234ef5678" }

    let(:transaction) do
      repo.create(
        uid: "test123",
        amount_usdt: 30,
        recipient_address: "tb1qxyz...",
        email: "user@example.com",
        exchange_fee_btc: 0.00001,
        network_fee_btc: 0.000006,
        estimated_btc: 0.00063,
        rate_btc: 0.00002151,
        status: "pending",
        created_at: Time.now,
        updated_at: Time.now
      )
    end

    it "updates transaction status to success and saves txid" do
      result = call

      expect(result).to be_success
      updated = repo.find_by_uid!(transaction[:uid])
      expect(updated[:status]).to eq("success")
      expect(updated[:txid]).to eq(txid)
    end
  end
end
