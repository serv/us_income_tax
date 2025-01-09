module USIncomeTax
  class BracketLibrary
    attr_accessor :content

    def initialize(hash)
      @content = {}
      populate_content(hash)
    end

    def populate_content(hash)
      hash.each do |year, types|
        @content[year] = BracketLibrary.serialize_types(year, types)
      end
    end

    def self.serialize_types(year, types)
      types_hash = {}
      types.map do |type, brackets|
        types_hash[type] = serialize_brackets(year, type, brackets)
      end
      types_hash
    end

    def self.serialize_brackets(year, type, brackets)
      brackets.map do |bracket|
        serialize_bracket(year, type, bracket)
      end
    end

    def self.serialize_bracket(year, type, bracket)
      Bracket.new(year, type, bracket["rate"], bracket["floor"], bracket["ceiling"])
    end
  end
end
