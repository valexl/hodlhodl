module Hodlhodl
  module Operations
    module Transactions
      class CreateTransaction
        include Deps[
          "gateways.coingecko_gateway",
          "use_cases.transactions.convert_to_btc",
          "use_cases.transactions.calculate_fees",
          "use_cases.transactions.start_transaction",
          "use_cases.transactions.broadcast_btc_transaction",
          "use_cases.transactions.success_transaction",
          "use_cases.transactions.failure_transaction"
        ]

        def call(attrs)
          rate = coingecko_gateway.call
          amount_btc = convert_to_btc.call(amount_usdt: attrs[:amount_usdt].to_f, rate: rate)
          fees = calculate_fees.call(amount_btc: amount_btc)

          start_result = start_transaction.call(attrs: attrs, rate: rate, fees: fees)

          return start_result if start_result.failure?

          transaction = start_result.value!
          recipient_address = transaction[:recipient_address]

          broadcast_result = broadcast_btc_transaction.call(
            recipient_address: transaction.recipient_address,
            send_amount: to_satoshi(transaction.estimated_btc),
            fee: to_satoshi(Hodlhodl::Config::Transaction.network_fee),
            sender_address: Hodlhodl::Config::Transaction.exchange_address,
            wif: Hodlhodl::Config::Transaction.exchange_wif
          )

          if broadcast_result.success?
            success_transaction.call(transaction:, txid: broadcast_result.value!)
          else
            failure_transaction.call(transaction:)
          end
        end

        def to_satoshi(value)
          (value * 100_000_000).to_i
        end        
      end
    end
  end
end