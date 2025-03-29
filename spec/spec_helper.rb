# frozen_string_literal: true

require "pathname"
require 'byebug'
SPEC_ROOT = Pathname(__dir__).realpath.freeze

ENV["HANAMI_ENV"] ||= "test"

require "webmock/rspec"
WebMock.disable_net_connect!(allow_localhost: true)

require "hanami/prepare"

SPEC_ROOT.glob("support/**/*.rb").each { |f| require f }
