# frozen_string_literal: true

module Hodlhodl
  module UseCases
    module Transactions
      class ConvertToBtc
        def call(amount_usdt:, rate:)
          (amount_usdt.to_f * rate.to_f).round(8)
        end
      end
    end
  end
end
