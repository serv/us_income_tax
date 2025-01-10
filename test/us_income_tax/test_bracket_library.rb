require "test_helper"

class TestUSIncomeTaxBracketLibrary < Minitest::Test
  def test_serialize_brackets
    year = "2024"
    type = "single"
    raw_brackets = [
      { "rate" => 10, "floor" => 0, "ceiling" => 11_600 },
      { "rate" => 12, "floor" => 11_601, "ceiling" => 47_150 },
      { "rate" => 22, "floor" => 47_151, "ceiling" => 100_525 },
      { "rate" => 24, "floor" => 100_526, "ceiling" => 191_950 },
      { "rate" => 32, "floor" => 191_951, "ceiling" => 243_725 },
      { "rate" => 35, "floor" => 243_726, "ceiling" => 609_350 },
      { "rate" => 37, "floor" => 609_351, "ceiling" => nil }
    ]
    brackets = ::USIncomeTax::BracketLibrary.serialize_brackets(year, type, raw_brackets)

    assert brackets[0].year == 2024
    assert brackets[0].type == :single
    assert brackets[0].rate == 0.1
    assert brackets[0].floor_amount == 0
    assert brackets[0].ceiling_amount == 11_600
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
