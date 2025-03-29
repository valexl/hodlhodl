RSpec.describe "GET /transactions/new", type: :request, db: true do

  it "renders the transaction when found" do
    get "/transactions/new"

    expect(last_response).to be_ok
    expect(last_response.body).to include("Wallet address")
  end
end
