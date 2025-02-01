require "test_helper"

class TestUSIncomeCalculationResult < Minitest::Test
  def test_assign_income_to_tax_brackets
    calculation_result = ::USIncomeTax::CalculationResult.new(2024, 777_777, :single)
    calculation_result.assign_income_to_tax_brackets

    bottom_bracket = calculation_result.brackets[calculation_result.year.to_s][calculation_result.type].first
    top_bracket = calculation_result.brackets[calculation_result.year.to_s][calculation_result.type].last

    assert bottom_bracket.year == 2024
    assert bottom_bracket.type == :single
    assert bottom_bracket.gross_amount == bottom_bracket.ceiling_amount

    assert top_bracket.gross_amount == 777_777.to_f - (top_bracket.floor_amount - 1)
  end
end
