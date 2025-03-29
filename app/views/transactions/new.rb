module Hodlhodl
  module Views
    module Transactions
      class New < Hodlhodl::View
        expose :errors, default: {}
        expose :values, default: {}
        expose :btc_rate, default: 0.0
      end
    end
  end
end