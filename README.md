# Quantity

Implements Unit and Quantity

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quantity'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quantity

## Usage

```ruby
meter = Unit.register 'meter'
centimeter = Unit.register 'centimeter', meter, 0.01
kilometer = Unit.register 'centimeter', meter, 1000

Quantity.new(1, meter) == Quantity.new(100, centimeter)      # => true
Quantity.new(78, centimeter).to_s                            # => "78 centimeter"
Quantity.new(78, meter).convert_to(centimeter).to_s          # => "7800 centimeter"
Quantity.new(1, kilometer).convert_to(centimeter).to_s       # => "100000 centimeter"
(Quantity.new(1, meter) - Quantity.new(25, centimeter)).to_s # => "0.75 meter"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/d-ark/quantity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
