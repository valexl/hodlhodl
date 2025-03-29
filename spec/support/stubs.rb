RSpec.configure do |config|
  config.before(:each) do |example|
    stub_request(:get, /coingecko/)
      .to_return(status: 200, body: load_fixture("coingecko/tether_btc.json"))

    stub_request(:post, "https://mempool.space/signet/api/tx")
      .to_return(status: 200, body: load_fixture("mempool/tx_success.json"), headers: { "Content-Type" => "application/json" })

    fixture_file =
      if example.metadata[:utxo_fixture] == :single
        "mempool/utxo_single.json"
      elsif example.metadata[:utxo_fixture] == :multiple
        "mempool/utxo_multiple.json"
      else
        "mempool/utxo_default.json"
      end

    stub_request(:get, /mempool.*\/utxo/)
      .to_return(
        status: 200,
        body: load_fixture(fixture_file),
        headers: { "Content-Type" => "application/json" }
      )      
  end
end
