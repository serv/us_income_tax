require "test_helper"

class TestUSIncomeTaxHsaMaxContributionDataLoader < Minitest::Test
  def test_load
    result = ::USIncomeTax::Hsa::MaxContributionDataLoader.load
    json = result.to_json

    assert json.is_a?(String)
  end
end
