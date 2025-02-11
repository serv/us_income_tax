require "test_helper"

class TestUSIncomeCalculator < Minitest::Test
  def test_calculate
    calculation_result = ::USIncomeTax::Calculator.calculate(2024, 777_777, :single, nil)

    bottom_bracket = calculation_result.brackets[calculation_result.year.to_s][calculation_result.type].first
    top_bracket = calculation_result.brackets[calculation_result.year.to_s][calculation_result.type].last

    # test_assign_income_to_tax_brackets
    assert bottom_bracket.year == 2024
    assert bottom_bracket.type == :single
    assert bottom_bracket.gross_amount == bottom_bracket.ceiling_amount

    assert top_bracket.gross_amount == 777_777.to_f - (top_bracket.floor_amount - 1)

    # test_calculate_tax_brackets
    expected_bottom_bracket_tax = bottom_bracket.ceiling_amount * bottom_bracket.rate
    expected_top_bracket_tax = top_bracket.gross_amount * top_bracket.rate

    assert bottom_bracket.tax_amount_intermediate == expected_bottom_bracket_tax
    assert bottom_bracket.tax_amount == expected_bottom_bracket_tax.round(2)

    assert top_bracket.tax_amount_intermediate == expected_top_bracket_tax
    assert top_bracket.tax_amount == expected_top_bracket_tax.round(2)

    # test_calculate_total_tax
    brackets = calculation_result.brackets[calculation_result.year.to_s][calculation_result.type]
    expected_sum = brackets.reduce(0) do |result, element|
      result + element.tax_amount
    end

    assert calculation_result.total_tax == expected_sum

    # test_calculate_net_income
    assert calculation_result.net_income == calculation_result.gross_income - calculation_result.total_tax
  end
end
