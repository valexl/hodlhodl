# frozen_string_literal: true

RSpec.describe Hodlhodl::Guards::Transactions::AmountGuard do
  describe ".call" do
    subject(:call) { described_class.call(input, btc_rate:) }
    let(:btc_rate) { 0.00002151 }

    context "when input is blank" do
      let(:input) { "" }

      it "returns error" do
        expect(call).to eq("is required")
      end
    end

    context "when input is zero" do
      let(:input) { "0" }

      it "returns error" do
        expect(call).to eq("must be greater than 0")
      end
    end

    context "when input is greater than 30" do
      let(:input) { "31" }

      it "returns error" do
        expect(call).to eq("must not exceed 30.0 USDT")
      end
    end

    context "when input is too small to cover fees" do
      let(:input) { "0.1" }

      it "returns error" do
        expect(call).to eq("too small — not enough to cover fees")
      end
    end

    context "when input is valid" do
      let(:input) { "30" }

      it "returns nil" do
        expect(call).to be_nil
      end
    end
  end
end
