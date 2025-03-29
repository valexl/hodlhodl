# frozen_string_literal: true

module Hodlhodl
  class Routes < Hanami::Routes
    get "/", to: "transactions.new"
    get "/transactions/new", to: "transactions.new"
    post "/transactions", to: "transactions.create"
    get "/transactions/:uid", to: "transactions.show"
  end
end
