RSpec.describe "GET /transactions/:uid", type: :request, db: true do
  let(:repo) { Hodlhodl::Repos::TransactionRepo.new }

  before do
    repo.create(
      uid: "abc123",
      amount_usdt: 1000,
      recipient_address: "1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE",
      exchange_fee_btc: 0.00005379,
      network_fee_btc: 0.0005,
      estimated_btc: 0.02096215,
      rate_btc: 0.00002151,
      created_at: Time.now,
      updated_at: Time.now
    )
  end

  it "renders the transaction when found" do
    get "/transactions/abc123"

    expect(last_response).to be_ok
    expect(last_response.body).to include("1000 USDT")
    expect(last_response.body).to include("0.00005379 BTC")
    expect(last_response.body).to include("1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE")
  end

  it "returns 404 when transaction is not found" do
    get "/transactions/missing"

    expect(last_response.status).to eq 404
    expect(last_response.body).to include("Page not found").or include("404")
  end
end
