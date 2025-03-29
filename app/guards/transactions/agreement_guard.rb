module Hodlhodl
  module Guards
    module Transactions
      class AgreementGuard
        def self.call(value)
          value == "on" ? nil : "must be accepted"
        end
      end
    end
  end
end
