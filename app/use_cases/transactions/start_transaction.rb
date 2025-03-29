# frozen_string_literal: true

require "dry/monads"

module Hodlhodl
  module UseCases
    module Transactions
      class StartTransaction
        include Deps["repos.transaction_repo"]
        include Dry::Monads[:result]

        def call(attrs:, rate:, fees:)
          errors = validate(attrs, rate)
          return Failure(errors) if errors.any?

          amount_usdt = attrs[:amount_usdt].to_f

          transaction = transaction_repo.create(
            uid: SecureRandom.hex(6),
            amount_usdt: amount_usdt.to_i,
            recipient_address: attrs[:wallet_address],
            email: attrs[:email],
            exchange_fee_btc: fees[:exchange_fee_btc],
            network_fee_btc: fees[:network_fee_btc],
            estimated_btc: fees[:estimated_btc],
            rate_btc: rate,
            created_at: Time.now,
            updated_at: Time.now
          )

          Success(transaction)
        end

        private

        def validate(attrs, rate)
          {
            amount_usdt: Guards::Transactions::AmountGuard.call(attrs[:amount_usdt], btc_rate: rate),
            wallet_address: Guards::Transactions::WalletAddressGuard.call(attrs[:wallet_address]),
            email: Guards::Transactions::EmailGuard.call(attrs[:email]),
            agree: Guards::Transactions::AgreementGuard.call(attrs[:agree])
          }.compact
        end
      end
    end
  end
end
