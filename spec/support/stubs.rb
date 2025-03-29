RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /coingecko/)
      .to_return(status: 200, body: load_fixture("coingecko/tether_btc.json"))
  end
end
