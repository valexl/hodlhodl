# frozen_string_literal: true

source "https://rubygems.org"

gem "hanami", "~> 2.2"
gem "hanami-assets", "~> 2.2"
gem "hanami-controller", "~> 2.2"
gem "hanami-db", "~> 2.2"
gem "hanami-router", "~> 2.2"
gem "hanami-validations", "~> 2.2"
gem "hanami-view", "~> 2.2"

gem "dry-types", "~> 1.7"
gem "dry-operation"
gem "puma"
gem "rake"
gem "pg"
gem "faraday"
gem 'bitcoinrb'

group :development do
  gem "hanami-webconsole", "~> 2.2"
end

group :development, :test do
  gem "dotenv"
  gem "byebug"
end

group :cli, :development do
  gem "hanami-reloader", "~> 2.2"
end

group :cli, :development, :test do
  gem "hanami-rspec", "~> 2.2"
end

group :test do
  # Database
  gem "database_cleaner-sequel"

  # Web integration
  gem "capybara"
  gem "rack-test"
end

gem "webmock", "~> 3.25", :group => :test
