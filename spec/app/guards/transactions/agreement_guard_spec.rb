# frozen_string_literal: true

RSpec.describe Hodlhodl::Guards::Transactions::AgreementGuard do
  describe ".call" do
    subject(:call) { described_class.call(value) }

    context "when checkbox is not checked" do
      let(:value) { nil }

      it "returns error" do
        expect(call).to eq("must be accepted")
      end
    end

    context "when value is 'off'" do
      let(:value) { "off" }

      it "returns error" do
        expect(call).to eq("must be accepted")
      end
    end

    context "when value is 'on'" do
      let(:value) { "on" }

      it "returns nil" do
        expect(call).to be_nil
      end
    end
  end
end
