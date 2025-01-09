module USIncomeTax
  class Bracket
    attr_accessor :year, :type, :rate, :floor_amount, :ceiling_amount

    def initialize(year, type, rate, floor_amount, ceiling_amount)
      @year = year.to_i
      @type = type.to_sym
      @rate = rate.to_f / 100
      @floor_amount = floor_amount
      @ceiling_amount = ceiling_amount
      @gross_amount = nil
      @tax_amount_intermediate = nil
      @tax_amount = nil
      @net_amount_intermediate = nil
      @net_amount = nil
    end

    def calculate_tax
      @tax_amount_intermediate = @gross_amount * @rate
      @tax_amount = @tax_amount_intermediate.round(2)
    end

    def calculate_net_income
      @net_amount_intermediate = @gross_amount - @tax_amount_intermediate
      @net_amount = @net_amount_intermediate.round(2)
    end
  end
end
