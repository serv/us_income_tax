module UsIncomeTax
  module Hsa
    class CalculationResult
      attr_accessor :year, :gross_income, :taxable_income, :options, :max_contributions

      def initialize(year, gross_income, options)
        @year = year
        @gross_income = gross_income
        @taxable_income = 0
        @options = options.hsa
        @max_contributions = MaxContributionDataLoader.load
      end

      def calculate
        validation_result = validate_inputs
        nil unless validation_result[:valid]

        # TODO: after checking validity, need to calculate taxable income, gross_income - options.hsa.hsa_contribution_amount
      end

      def validate_inputs
        year_contributions = @max_contributions[@year.to_s]

        if @options.hsa.hsa_type == "self-only"
          if @options.hsa.hsa_contribution_amount > year_contributions["self-only"]
            {
              valid: false,
              message: "HSA contribution amount exceeds the maximum contribution amount for self-only HSA"
            }
          else
            {
              valid: true,
              message: nil
            }
          end
        elsif @options.hsa.hsa_type == "family"
          if @options.hsa.hsa_contribution_amount > year_contributions["family"]
            {
              valid: false,
              message: "HSA contribution amount exceeds the maximum contribution amount for family HSA"
            }
          else
            {
              valid: true,
              message: nil
            }
          end
        end
        # TODO: handle additional-catch-up
      end
    end
  end
end
