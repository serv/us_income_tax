require "test_helper"

class TestUSIncomeTaxBracketLoader < Minitest::Test
  def test_load
    result = ::USIncomeTax::BracketLoader.load
    json = result.to_json

    assert json.is_a?(String)
  end
end
