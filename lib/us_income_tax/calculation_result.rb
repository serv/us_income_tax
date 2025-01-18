module USIncomeTax
  class CalculationResult

    def initialize(year, gross_income, type)
      @year = year
      @gross_income = gross_income
      @type = type

      @brackets = nil
      @total_tax = nil
      @net_income = nil
    end
  end
end
