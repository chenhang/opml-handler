# Opml::Handler

Handle opml(xml) in your ruby application

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opml-handler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opml-handler

## Usage

Export ruby hash to opml

```ruby
require 'opml-handler'
data = [{text: 'First level',
         children: [{text: 'Second Level',
                     children: [{text: 'Item 1', _note: "Some notes", children: []},
                                {text: 'Item 2', children: []}]
                    }
         ]
        }]
opml = OpmlHandler::Opml.new('', "title")

puts opml.to_xml
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/opml-handler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

