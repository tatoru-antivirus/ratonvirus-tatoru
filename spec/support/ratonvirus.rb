require "ratonvirus"

RSpec.configure do |config|
  config.before(:each) do
    # Reset the config before each test
    Ratonvirus.reset

    # Configure a storage backend to be able to call scanner.virus?
    Ratonvirus.configure do |rv_config|
      rv_config.storage = :filepath
      rv_config.addons = []
    end
  end
end
