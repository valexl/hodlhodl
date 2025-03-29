module FixtureHelper
  def load_fixture(path)
    File.read(File.join(SPEC_ROOT, "fixtures", path))
  end
end

RSpec.configure do |config|
  config.include FixtureHelper
end
