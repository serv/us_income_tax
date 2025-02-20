# USIncomeTax

Calculate US Federal Income Tax

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/us_income_tax`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add us_income_tax

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install us_income_tax

## Usage

```ruby
year = 2024 # Supports 2024 and 2025 only
gross_income = 777777
type = :single # Supports :single, :married_filing_jointly, :married_filing_separately, :head_of_household

calculation_result = Calculator.calculate(year, gross_income, type)

tax_brackets = calculation_result.brackets[calculation_result.year.to_s][calculation_result.type]
total_tax = calculation_result.total_tax 
net_income = calculation_result.net_income
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Links

- [2024 and 2025 tax brackets and federal income tax rates](https://www.fidelity.com/learning-center/personal-finance/tax-brackets)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/serv/us_income_tax.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
