module USIncomeTax
  module Hsa
    class TaxableIncomeCalculator
      def self.calculate(year, gross_income, options)
        calculation_result = CalculationResult.new(year, gross_income, options)
        calculation_result.calculate
        calculation_result
      end
    end
  end
end
