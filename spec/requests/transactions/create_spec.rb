# frozen_string_literal: true

RSpec.describe "POST /transactions", type: :request, db: true do
  let(:repo) { Hodlhodl::Repos::TransactionRepo.new }

  it "creates a transaction and redirects" do
    post "/transactions", {
      amount_usdt: "30",
      wallet_address: "1BoatSLRHtKNngkdXEeobR76b53LETtpyT",
      email: "user@example.com",
      agree: "on"
    }

    expect(last_response.status).to eq(302) # redirect
    expect(last_response.headers["Location"]).to match(%r{/transactions/\h+})

    uid = last_response.headers["Location"].split("/").last
    transaction = repo.find_by_uid!(uid)

    expect(transaction[:amount_usdt]).to eq(30)
    expect(transaction[:recipient_address]).to eq("1BoatSLRHtKNngkdXEeobR76b53LETtpyT")
    expect(transaction[:email]).to eq("user@example.com")
  end

  it "returns error when email is invalid" do
    post "/transactions", {
      amount_usdt: "20",
      wallet_address: "1BoatSLRHtKNngkdXEeobR76b53LETtpyT",
      email: "not-an-email",
      agree: "on"
    }

    expect(last_response.status).to eq(422)
    expect(last_response.body).to include("must be a valid email")
  end  

  it "returns validation error when amount > 30" do
    post "/transactions", {
      amount_usdt: "100",
      wallet_address: "1BoatSLRHtKNngkdXEeobR76b53LETtpyT",
      email: "user@example.com",
      agree: "on"
    }

    expect(last_response.status).to eq(422)
    expect(last_response.body).to include("must not exceed 30.0 USDT")
  end

  it "returns error when wallet_address is missing" do
    post "/transactions", {
      amount_usdt: "20",
      email: "user@example.com",
      agree: "on"
    }

    expect(last_response.status).to eq(422)
    expect(last_response.body).to include("wallet address is required")
  end  

  it "returns error when amount_usdt is negative" do
    post "/transactions", {
      amount_usdt: "-10",
      wallet_address: "1BoatSLRHtKNngkdXEeobR76b53LETtpyT",
      email: "user@example.com",
      agree: "on"
    }

    expect(last_response.status).to eq(422)
    expect(last_response.body).to include("must be greater than 0")
  end  

  it "returns validation error when checkbox is not checked" do
    post "/transactions", {
      amount_usdt: "20",
      wallet_address: "1BoatSLRHtKNngkdXEeobR76b53LETtpyT",
      email: "user@example.com"
    }

    expect(last_response.status).to eq(422)
    expect(last_response.body).to include("must be accepted")
  end
end
