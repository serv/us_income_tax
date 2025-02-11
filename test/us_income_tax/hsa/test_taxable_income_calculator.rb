require "test_helper"

class TestUSIncomeTaxHsaTaxableIncomeCalculator < Minitest::Test
  def test_calculate
    # (year, gross_income, options)
    year = 2024
    gross_income = 777_777
    hsa_contribution_amount = 4000
    hsa_type = "self-only"
    options = USIncomeTax::DTO::CalculationResultOptions.new({ hsa: { year: year, hsa_contribution_amount: hsa_contribution_amount,
                                                                      hsa_type: hsa_type } })

    hsa_calculation_result = USIncomeTax::Hsa::TaxableIncomeCalculator.calculate(year, gross_income, options.hsa)

    expected_taxable_income = gross_income - hsa_contribution_amount
    assert hsa_calculation_result.validate_inputs[:valid] == true
    assert hsa_calculation_result.taxable_income == expected_taxable_income
  end
end
