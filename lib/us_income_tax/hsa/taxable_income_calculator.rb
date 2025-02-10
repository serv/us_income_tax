module USIncomeTax
  module Hsa
    class TaxableIncomeCalculator
      calculation_result = Hsa::CalculationResult.new(year, gross_income, type, options)
      calculation_result.calculate
      calculation_result
    end
  end
end
