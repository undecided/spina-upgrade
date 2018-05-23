# Spina::Upgrade
This gem is meant for upgrading your Spina project from 0.X to 1.0 with support for ActiveStorage. All records of `Spina::Photo` will be reuploaded as `Spina::Image`. Make sure that you setup ActiveStorage before running the upgrade.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'spina-upgrade'
```

## Usage
Simply run the upgrade generator.

```
rails g spina:upgrade
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
