module USIncomeTax
  module Hsa
    class CalculationResult
      attr_accessor :year, :gross_income, :taxable_income, :options, :max_contributions

      def initialize(year, gross_income, hsa_options)
        @year = year
        @gross_income = gross_income
        @taxable_income = 0
        @options = hsa_options
        @max_contributions = MaxContributionDataLoader.load
      end

      def calculate
        validation_result = validate_inputs
        nil unless validation_result[:valid]

        @taxable_income = @gross_income - @options.hsa_contribution_amount
      end

      def validate_inputs
        year_contributions = @max_contributions[@year.to_s]

        if @options.hsa_type == "self-only"
          if @options.hsa_contribution_amount > year_contributions["self-only"]
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
        elsif @options.hsa_type == "family"
          if @options.hsa_contribution_amount > year_contributions["family"]
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
