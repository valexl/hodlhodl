# frozen_string_literal: true
require 'net/http'
require 'json'

module Hodlhodl
  module Gateways
    class CoingeckoGateway
      API_URL = "https://api.coingecko.com/api/v3/simple/price?ids=tether&vs_currencies=btc"

      def call
        uri = URI(API_URL)
        response = Net::HTTP.get(uri)
        JSON.parse(response)["tether"]["btc"]
      rescue
        # если 429, то нужно вернуть хоть что-то
        # в реальности нужно покупать подпски, делать троттелинг + кэшироавть ответы
        0.00001187 
      end
    end
  end
end
