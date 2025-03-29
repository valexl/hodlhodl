module Hodlhodl
  module Operations
    module Transactions
      class CreateTransaction
        include Deps[
          "repos.transaction_repo",
          "gateways.coingecko_gateway"
        ]

        def call(attrs)
          amount = attrs[:amount_usdt].to_f
          rate = coingecko_gateway.call

          errors = {
            amount_usdt: Guards::Transactions::AmountGuard.call(amount, btc_rate: rate),
            wallet_address: Guards::Transactions::WalletAddressGuard.call(attrs[:wallet_address]),
            email: Guards::Transactions::EmailGuard.call(attrs[:email]),
            agree: Guards::Transactions::AgreementGuard.call(attrs[:agree])
          }.compact

          return [:error, errors] if errors.any?

          transaction = transaction_repo.create(
            uid: SecureRandom.hex(6),
            amount_usdt: amount.to_i,
            recipient_address: attrs[:wallet_address],
            email: attrs[:email],
            exchange_fee_btc: Hodlhodl::Config::Transaction.exchange_fee_for(amount),
            network_fee_btc: Hodlhodl::Config::Transaction.network_fee,
            estimated_btc: Hodlhodl::Guards::Transactions::AmountGuard.estimated_btc(amount, rate),
            rate_btc: rate,
            created_at: Time.now,
            updated_at: Time.now
          )

          [:ok, transaction]
        end
      end
    end
  end
end