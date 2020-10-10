RSpec::Mocks::Double.module_eval do
  alias to_str to_s
end
