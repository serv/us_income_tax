module USIncomeTax
  class Calculator
    def self.calculate(year, gross_income, type)
      calculation_result = CalculationResult.new(year, gross_income, type)
      calculation_result.calculate
      calculation_result
    end
  end
end
