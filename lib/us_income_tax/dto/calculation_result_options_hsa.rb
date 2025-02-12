module USIncomeTax
  module DTO
    class CalculationResultOptionsHsa
      attr_accessor :year, :hsa_contribution_amount, :hsa_type

      def initialize(hsa_options)
        @year = hsa_options[:year]
        @hsa_contribution_amount = hsa_options[:hsa_contribution_amount]
        @hsa_type = hsa_options[:hsa_type]
      end
    end
  end
end
