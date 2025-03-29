# frozen_string_literal: true

module Hodlhodl
  module Actions
    module Transactions
      class New < Hodlhodl::Action
        include Deps["gateways.coingecko_gateway"]

        def handle(request, response)
          response.render(view, btc_rate: coingecko_gateway.call)
        end

        private

        def view = Hodlhodl::Views::Transactions::New.new
      end
    end
  end
end
