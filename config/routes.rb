# frozen_string_literal: true

module Hodlhodl
  class Routes < Hanami::Routes
    get "/transactions/:uid", to: "transactions.show"
  end
end
