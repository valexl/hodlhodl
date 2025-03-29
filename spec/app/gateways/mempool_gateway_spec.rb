# frozen_string_literal: true

RSpec.describe Hodlhodl::Gateways::MempoolGateway do
  subject(:gateway) { described_class.new }

  describe "#call" do
    subject(:call) { gateway.call(raw_tx_hex) }

    let(:raw_tx_hex) { "deadbeef" }

    context "when the API returns success" do
      it "returns txid from the response" do
        expect(call).to eq("abcd1234efgh5678")
      end
    end

    context "when the API returns a 500 error" do
      before do
        stub_request(:post, "https://mempool.space/signet/api/tx")
          .to_return(status: 500, body: "boom")
      end

      it "returns nil" do
        expect(call).to be_nil
      end
    end

    context "when Faraday raises an exception" do
      before do
        stub_request(:post, "https://mempool.space/signet/api/tx")
          .to_raise(Faraday::TimeoutError)
      end

      it "returns nil" do
        expect(call).to be_nil
      end
    end
  end
end
