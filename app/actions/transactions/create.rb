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
          result_type, payload = create_transaction.call(request.params.to_h)

          if result_type == :ok
            response.redirect "/transactions/#{payload[:uid]}"
          else
            response.status = 422
            response.render view, errors: payload, values: request.params.to_h, btc_rate: coingecko_gateway.call
          end
        end

        private

        def view = Hodlhodl::Views::Transactions::New.new
      end
    end
  end
end
