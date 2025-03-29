# frozen_string_literal: true

RSpec.describe Hodlhodl::Guards::Transactions::WalletAddressGuard do
  describe ".call" do
    subject(:call) { described_class.call(address) }

    context "when blank" do
      let(:address) { "" }

      it "returns error" do
        expect(call).to eq("wallet address is required")
      end
    end

    context "when format is invalid" do
      let(:address) { "12345" }

      it "returns error" do
        expect(call).to eq("must be a valid BTC address")
      end
    end

    context "when P2PKH address" do
      let(:address) { "1BoatSLRHtKNngkdXEeobR76b53LETtpyT" }

      it "returns nil" do
        expect(call).to be_nil
      end
    end

    context "when P2SH address" do
      let(:address) { "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy" }

      it "returns nil" do
        expect(call).to be_nil
      end
    end

    context "when bech32 (P2WPKH) address" do
      let(:address) { "bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kygt080" }

      it "returns nil" do
        expect(call).to be_nil
      end
    end
  end
end
