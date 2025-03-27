# frozen_string_literal: true

RSpec.describe "Root", type: :request do
  it "is not found" do
    get "/"

    # Generate new action via:
    #   `bundle exec hanami generate action home.index --url=/`
    expect(last_response).to be_successful
  end
end
