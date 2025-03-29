# frozen_string_literal: true

require "net/http"

RSpec.describe Hodlhodl::Gateways::CoingeckoGateway, stub_coingecko: true do
  subject(:provider) { described_class.new }

  let(:api_url) {
    URI("https://api.coingecko.com/api/v3/simple/price?ids=tether&vs_currencies=btc")
  }

  it "returns the parsed BTC rate from API" do
    expect(provider.call).to eq(0.00001234)
  end

  it "returns fallback value when API call fails" do
    allow(Net::HTTP).to receive(:get).and_raise(Timeout::Error)

    expect(provider.call).to eq(0.00001187)
  end
end
