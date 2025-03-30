module Hodlhodl
  module Guards
    module Transactions
      class WalletAddressGuard
        def self.call(address)
          return "wallet address is required" if address.to_s.strip.empty?

          return if address.match?(/\A([13][a-km-zA-HJ-NP-Z1-9]{25,34}|(bc1|tb1)[a-z0-9]{39,59})\z/)
            
          "must be a valid BTC address"
        end
      end
    end
  end
end
