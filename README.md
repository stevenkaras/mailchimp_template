# MailchimpTemplate

Ruby implementation of [Mailchimp's Template Language][mc-template-language]. Not everything works, but I'll add more support as I get requests.

[mc-template-language]: http://kb.mailchimp.com/templates/code/getting-started-with-mailchimps-template-language "Mailchimp Template Langauge Official Documentation"

## Currently Supported Features

- [x] Generic Merge Tags
- [ ] System Merge Tags
- [ ] Editable regions
- [ ] Repeatable regions

## Installation

Add this line to your application's Gemfile:

    gem 'mailchimp_template'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailchimp_template

## Usage

```ruby
template = MailchimpTemplate.new("hello, *|MERGETAG|*")
template.render(merge_tags: {"MERGETAG" => "world"})
```

## Contributing

1. Fork it ( https://github.com/stevenkaras/mailchimp_template/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
