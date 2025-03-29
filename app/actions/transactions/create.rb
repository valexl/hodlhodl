# frozen_string_literal: true

module Hodlhodl
  module Actions
    module Transactions
      class Create < Hodlhodl::Action
        include Deps[
          "operations.transactions.create_transaction",
          "gateways.coingecko_gateway"
        ]


        def handle(request, response)
          result = create_transaction.call(request.params.to_h)

          if result.success?
            transaction = result.value!
            response.redirect "/transactions/#{transaction[:uid]}"
          else
            errors = result.failure
            response.status = 422
            response.render view, errors: errors, values: request.params.to_h, btc_rate: coingecko_gateway.call
          end
        end

        private

        def view = Hodlhodl::Views::Transactions::New.new
      end
    end
  end
end
