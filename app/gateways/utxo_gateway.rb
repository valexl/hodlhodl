# frozen_string_literal: true

require "faraday"
require "json"

module Hodlhodl
  module Gateways
    class UtxoGateway
      API_URL = "https://mempool.space/signet/api/address"

      def call(address)
        url = "#{API_URL}/#{address}/utxo"
        response = Faraday.get(url)
        JSON.parse(response.body, symbolize_names: true)
      rescue StandardError
        []
      end
    end
  end
end
