require "json"

module USIncomeTax
  class BracketLoader
    FILE_PATH = "../../data/federal_tax_bracket.json"

    def self.load
      json_file_path = File.expand_path(FILE_PATH, __dir__)
      file = File.read(json_file_path)
      JSON.parse(file)
    end
  end
end
