module USIncomeTax
  class Bracket

    def initialize(year, type, gross_amount)
      @year = year
      @type = type
      @rate = nil
      @floor_amount = nil
      @ceiling_amount = nil
      @gross_amount = gross_amount
      @tax_amount = nil
      @net_amount = nil
    end
  end
end
