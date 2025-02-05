# frozen_string_literal: true

require_relative "us_income_tax/version"
require_relative "us_income_tax/bracket_library"
require_relative "us_income_tax/bracket_loader"
require_relative "us_income_tax/bracket"
require_relative "us_income_tax/calculation_result"
require_relative "us_income_tax/calculator"

module USIncomeTax
  class Error < StandardError; end
  # Your code goes here...
end
