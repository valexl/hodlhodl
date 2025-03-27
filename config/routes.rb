# frozen_string_literal: true

module Hodlhodl
  class Routes < Hanami::Routes
    slice :web, at: "/" do
      get "/", to: "home.index"
    end
  end
end
