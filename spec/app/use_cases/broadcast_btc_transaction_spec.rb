# frozen_string_literal: true

RSpec.describe Hodlhodl::UseCases::Transactions::BroadcastBtcTransaction do
  subject(:use_case) { described_class.new }

  let(:recipient_address) { "tb1q0upe2vsywx6hnu4cke8kvkdejd97kjg4qq5xmf" }
  let(:sender_address) { "tb1q9qgrcmqy7cvj078yjgwdr9qm6wlx46eupa9znl" }
  let(:wif) { "cMzw1SVTPC7xiYWTSxWSPSEPeEEVwyjx4anLQb7QXPVod7hsgPin" }

  let(:send_amount) { 1_000 }
  let(:fee) { 200 }

  describe "#call" do
    subject(:call) do
      use_case.call(
        recipient_address:,
        sender_address:,
        wif:,
        send_amount:,
        fee:
      )
    end

    it "returns Success with txid" do
      expect(call).to be_success
      expect(call.value!).to match(/\A\h{64}\z/)
    end

    context "when insufficient funds" do
      let(:send_amount) { 100_000 }

      it "returns Failure(:invalid_tx)" do
        expect(call).to be_failure
        expect(call.failure).to eq(:invalid_tx)
      end
    end
  end
end
