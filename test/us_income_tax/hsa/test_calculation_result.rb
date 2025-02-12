require "test_helper"

class TestUSIncomeTaxHsaCalculationResult < Minitest::Test
  def test_validate_inputs
    year = 2024
    gross_income = 777_777
    hsa_contribution_amount = 5000 # This is greater than the max contrib amount for 2024, self-only
    hsa_type = "self-only"
    options = USIncomeTax::DTO::CalculationResultOptions.new({ hsa: { year: year, hsa_contribution_amount: hsa_contribution_amount,
                                                                      hsa_type: hsa_type } })
    hsa_calculation_result = USIncomeTax::Hsa::CalculationResult.new(year, gross_income, options.hsa)

    assert hsa_calculation_result.validate_inputs[:valid] == false
  end

  def test_calculate
    year = 2024
    gross_income = 777_777
    hsa_contribution_amount = 4000
    hsa_type = "self-only"
    options = USIncomeTax::DTO::CalculationResultOptions.new({ hsa: { year: year, hsa_contribution_amount: hsa_contribution_amount,
                                                                      hsa_type: hsa_type } })
    hsa_calculation_result = USIncomeTax::Hsa::CalculationResult.new(year, gross_income, options.hsa)
    hsa_calculation_result.calculate

    expected_taxable_income = gross_income - hsa_contribution_amount
    assert hsa_calculation_result.validate_inputs[:valid] == true
    assert hsa_calculation_result.taxable_income == expected_taxable_income
  end
end
