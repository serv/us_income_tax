require "json"

module USIncomeTax
  module Hsa
    class MaxContributionDataLoader
      FILE_PATH = "../../../data/hsa_max_contribution.json"

      def self.load
        json_file_path = File.expand_path(FILE_PATH, __dir__)
        file = File.read(json_file_path)
        JSON.parse(file)
      end
    end
  end
end
