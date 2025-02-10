module USIncomeTax
  class CalculationResult
    attr_accessor :year, :gross_income, :taxable_income, :type, :brackets, :total_tax, :net_income, :options

    def initialize(year, gross_income, type, options)
      @year = year
      @gross_income = gross_income
      @taxable_income = @gross_income # By default, taxable income is the same as the gross income
      @type = type

      loaded_static_brackets = ::USIncomeTax::BracketLoader.load

      @brackets = BracketLibrary.new(loaded_static_brackets).content
      @total_tax = nil
      @net_income = nil
      @options = DTO::CalculationResultOptions.new(options)
    end

    def calculate
      assign_income_to_tax_brackets
      calculate_tax_brackets
      calculate_taxable_income
      calculate_total_tax
      calculate_net_income
    end

    def assign_income_to_tax_brackets
      types_in_year = @brackets[@year.to_s]
      brackets_in_type = types_in_year[@type.to_sym]

      remaining_gross_income = @gross_income
      brackets_in_type.each do |bracket|
        bracket.hold_gross_amount(remaining_gross_income)
        remaining_gross_income -= bracket.gross_amount
      end
    end

    # Must call assign_income_to_tax_brackets before usage
    def calculate_taxable_income
      return unless @options.hsa

      hsa_calculation_result = Hsa::TaxableIncomeCalculator.calculate(@year, @gross_income, @options.hsa)
      @taxable_income = hsa_calculation_result.taxable_income
    end

    # Must call calculate_taxable_income before usage
    def calculate_tax_brackets
      types_in_year = @brackets[@year.to_s]
      brackets_in_type = types_in_year[@type.to_sym]

      brackets_in_type.each do |bracket|
        bracket.calculate_tax
      end
    end

    # Must call calculate_tax_brackets before usage
    def calculate_total_tax
      types_in_year = @brackets[@year.to_s]
      brackets_in_type = types_in_year[@type.to_sym]

      @total_tax = brackets_in_type.reduce(0) do |result, element|
        result + element.tax_amount
      end
    end

    def calculate_net_income
      @net_income = @gross_income - @total_tax
    end
  end
end
