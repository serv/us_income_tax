module USIncomeTax
  class Calculator
    # TODO

    def calculate(year, gross_income, type)
      calculation_result = CalculationResult.new(year, gross_income, type)
      calculation_result.calculate
    end
  end
end
