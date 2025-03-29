module Hodlhodl
  module Guards
    module Transactions
      class AmountGuard
        include Hodlhodl::Config::Transaction

        def self.call(raw, btc_rate:)
          amount = raw.to_f

          
          return "is required" if raw.to_s.strip.empty?
          return "must be greater than 0" if amount <= 0
          return "must not exceed #{MAX_USDT} USDT" if amount > MAX_USDT
          return "too small — not enough to cover fees" if estimated_btc(amount, btc_rate) < 0

          nil
        end

        def self.estimated_btc(amount, btc_rate)
          btc_amount = amount * btc_rate
          (btc_amount - Hodlhodl::Config::Transaction.exchange_fee_for(btc_amount) - Hodlhodl::Config::Transaction.network_fee).round(8)
        end
      end
    end
  end
end
