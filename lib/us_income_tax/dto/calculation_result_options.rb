module USIncomeTax
  module DTO
    class CalculationResultOptions
      attr_accessor :hsa

      def initialize(options)
        return if options[:hsa].nil?

        @hsa = CalculationResultOptionsHsa.new(options[:hsa])
      end
    end
  end
end
