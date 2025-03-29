# frozen_string_literal: true

module Hodlhodl
  module UseCases
    module Transactions
      class CalculateFees
        def call(amount_btc:)
          exchange_fee = Hodlhodl::Config::Transaction.exchange_fee_for(amount_btc)
          network_fee = Hodlhodl::Config::Transaction.network_fee
          estimated_btc = (amount_btc - exchange_fee - network_fee).round(8)

          {
            exchange_fee_btc: exchange_fee,
            network_fee_btc: network_fee,
            estimated_btc: estimated_btc
          }
        end
      end
    end
  end
end
