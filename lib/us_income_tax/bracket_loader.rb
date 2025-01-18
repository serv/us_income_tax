require "json"

module USIncomeTax
  class BracketLoader
    FILE_PATH = "data/federal_tax_bracket.json"

    def self.load
      file = File.read(FILE_PATH)
      data_hash = JSON.parse(file)
    end
  end
end
