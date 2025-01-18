require "test_helper"

class TestUSIncomeTaxBracketLibrary < Minitest::Test
  def test_populate_content
    loaded = ::USIncomeTax::BracketLoader.load
    bracket_library = ::USIncomeTax::BracketLibrary.new(loaded)

    assert bracket_library.content["2024"][:single][0].year == 2024
    assert bracket_library.content["2024"][:single][0].type == :single
    assert bracket_library.content["2024"][:single][0].rate == 0.1
    assert bracket_library.content["2024"][:single][0].floor_amount == 0
    assert bracket_library.content["2024"][:single][0].ceiling_amount == 11_600
  end

  def test_serialize_types
    year = "2025"
    types = {
      "single" => [
        { "rate" => 10, "floor" => 0, "ceiling" => 11_600 },
        { "rate" => 12, "floor" => 11_601, "ceiling" => 47_150 },
        { "rate" => 22, "floor" => 47_151, "ceiling" => 100_525 },
        { "rate" => 24, "floor" => 100_526, "ceiling" => 191_950 },
        { "rate" => 32, "floor" => 191_951, "ceiling" => 243_725 },
        { "rate" => 35, "floor" => 243_726, "ceiling" => 609_350 },
        { "rate" => 37, "floor" => 609_351, "ceiling" => nil }
      ],
      "married_filing_jointly" => [
        { "rate" => 10, "floor" => 0, "ceiling" => 23_200 },
        { "rate" => 12, "floor" => 23_201, "ceiling" => 94_300 },
        { "rate" => 22, "floor" => 94_301, "ceiling" => 201_050 },
        { "rate" => 24, "floor" => 201_051, "ceiling" => 383_900 },
        { "rate" => 32, "floor" => 383_901, "ceiling" => 487_450 },
        { "rate" => 35, "floor" => 487_451, "ceiling" => 731_200 },
        { "rate" => 37, "floor" => 731_201, "ceiling" => nil }
      ],
      "married_filing_separately" => [
        { "rate" => 10, "floor" => 0, "ceiling" => 11_600 },
        { "rate" => 12, "floor" => 11_601, "ceiling" => 47_150 },
        { "rate" => 22, "floor" => 47_151, "ceiling" => 100_525 },
        { "rate" => 24, "floor" => 100_526, "ceiling" => 191_950 },
        { "rate" => 32, "floor" => 191_951, "ceiling" => 243_725 },
        { "rate" => 35, "floor" => 243_726, "ceiling" => 365_600 },
        { "rate" => 37, "floor" => 365_601, "ceiling" => nil }
      ],
      "head_of_household" => [
        { "rate" => 10, "floor" => 0, "ceiling" => 16_550 },
        { "rate" => 12, "floor" => 16_551, "ceiling" => 63_100 },
        { "rate" => 22, "floor" => 63_101, "ceiling" => 100_500 },
        { "rate" => 24, "floor" => 100_501, "ceiling" => 191_950 },
        { "rate" => 32, "floor" => 191_951, "ceiling" => 243_700 },
        { "rate" => 35, "floor" => 243_701, "ceiling" => 609_350 },
        { "rate" => 37, "floor" => 609_351, "ceiling" => nil }
      ]
    }
    serialized = ::USIncomeTax::BracketLibrary.serialize_types(year, types)

    %i[single married_filing_jointly married_filing_separately head_of_household].each do |t|
      assert !t.nil?
    end
    assert serialized[:single][0].year == 2025
    assert serialized[:single][0].type == :single
    assert serialized[:single][0].rate == 0.1
    assert serialized[:single][0].floor_amount == 0
    assert serialized[:single][0].ceiling_amount == 11_600
  end

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
