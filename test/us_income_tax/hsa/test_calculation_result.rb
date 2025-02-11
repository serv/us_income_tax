require "test_helper"

class TestUSIncomeTaxHsaCalculationResult < Minitest::Test
  def test_validate_inputs
    year = 2024
    gross_income = 777_777
    hsa_contribution_amount = 5000
    options = USIncomeTax::DTO::CalculationResultOptions.new({ hsa: { year: year, hsa_contribution_amount: hsa_contribution_amount,
                                                                      hsa_type: "self-only" } })
    hsa_calculation_result = USIncomeTax::Hsa::CalculationResult.new(year, gross_income, options.hsa)

    assert hsa_calculation_result.validate_inputs[:valid] == false
  end

  def test_calculate
  end
end
