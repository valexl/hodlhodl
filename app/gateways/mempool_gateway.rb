# frozen_string_literal: true

require "faraday"
require "json"

module Hodlhodl
  module Gateways
    class MempoolGateway
      API_URL = "https://mempool.space/signet/api/tx"

      def call(raw_tx_hex)
        response = Faraday.post(API_URL, raw_tx_hex)

        return response.body if response.success?

        nil
      rescue StandardError
        nil
      end
    end
  end
end
