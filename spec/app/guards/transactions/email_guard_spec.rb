# frozen_string_literal: true

RSpec.describe Hodlhodl::Guards::Transactions::EmailGuard do
  describe ".call" do
    subject(:call) { described_class.call(email) }

    context "when blank" do
      let(:email) { "" }

      it "returns error" do
        expect(call).to eq("email is required")
      end
    end

    context "when format is invalid" do
      let(:email) { "not-an-email" }

      it "returns error" do
        expect(call).to eq("must be a valid email")
      end
    end

    context "when format is valid" do
      let(:email) { "user@example.com" }

      it "returns nil" do
        expect(call).to be_nil
      end
    end
  end
end
