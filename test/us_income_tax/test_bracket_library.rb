require "test_helper"

class TestUSIncomeTaxBracketLibrary < Minitest::Test
  def test_serialize_brackets
    # TODO
  end

  def test_serialize_bracket
    year = "2024"
    type = "single"
    raw_bracket = { "rate" => 10, "floor" => 0, "ceiling" => 11_600 }
    bracket = ::USIncomeTax::BracketLibrary.serialize_bracket(year, type, raw_bracket)

    assert bracket.year == 2024
    assert bracket.type == :single
    assert bracket.rate == 0.1
    assert bracket.floor_amount == 0
    assert bracket.ceiling_amount == 11_600
  end
end
