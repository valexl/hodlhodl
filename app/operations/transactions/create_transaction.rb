module Hodlhodl
  module Operations
    module Transactions
      class CreateTransaction
        include Deps[
          "gateways.coingecko_gateway",
          "use_cases.transactions.convert_to_btc",
          "use_cases.transactions.calculate_fees",
          "use_cases.transactions.start_transaction"
        ]

        def call(attrs)
          rate = coingecko_gateway.call
          amount_btc = convert_to_btc.call(amount_usdt: attrs[:amount_usdt].to_f, rate: rate)
          fees = calculate_fees.call(amount_btc: amount_btc)

          result = start_transaction.call(attrs: attrs, rate: rate, fees: fees)
        end
      end
    end
  end
end