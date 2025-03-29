# frozen_string_literal: true

RSpec.describe Hodlhodl::Gateways::UtxoGateway do
  subject(:gateway) { described_class.new }

  describe "#call" do
    it "returns parsed utxos from API" do
      utxos = gateway.call("dummy_address")
      expect(utxos).to be_an(Array)
      expect(utxos.first).to include(:txid, :vout, :value)
    end

    it "returns empty array on error" do
      stub_request(:get, /address\/fail\/utxo/)
        .to_raise(Faraday::ConnectionFailed)

      expect(gateway.call("fail")).to eq([])
    end
  end
end
