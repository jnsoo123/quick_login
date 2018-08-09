# QuickLogin
Quick Login Engine that uses Devise Gem in an app.

## Usage
Use the view helper in your views with a parameter of a model that uses `Devise`
NOTE: This will raise an error if your model doesn't have devise included.

```ruby
quick_login_table User
```

By default, it'll show all the fields except for timestamp and devise fields:
```ruby
[:encrypted_password, :reset_password_token,
:reset_password_sent_at, :remember_created_at,
:sign_in_count, :current_sign_in_ip, :last_sign_in_ip,
:current_sign_in_at, :last_sign_in_at, :created_at, :updated_at]
```

But you can add `show_fields` parameter to display the fields you wanted.

```ruby
quick_login_table User, show_fields: [:first_name, :last_name, :age]
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'quick_login'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install quick_login
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
