# app/config.rb
module Hodlhodl
  module Config
    module Transaction
      MAX_USDT = 30.0
      EXCHANGE_FEE_PERCENT = 0.03
      NETWORK_FEE_BTC = 0.000006

      def self.exchange_fee_for(amount)
        (amount * EXCHANGE_FEE_PERCENT).round(8)
      end

      def self.network_fee
        NETWORK_FEE_BTC
      end

      def self.exchange_address
        ENV.fetch("EXCHANGE_ADDRESS")
      end

      def self.exchange_wif
        ENV.fetch("EXCHANGE_WIF")
      end
    end
  end
end
