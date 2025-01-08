module USIncomeTax
  # Interface for us_income_tax gem
  class Scenario
    attr_accessor :result

    def initialize(year, gross_income, type)
      @year = year
      @gross_income = gross_income
      @type = type # TODO: Validate this against 4 types
      @result = nil
    end

    def calculate
      @result = Calculator.calculate(@year, @gross_income, @type)
    end
  end
end
