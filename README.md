# QuickLogin
Quick Login Engine that uses Devise Gem in an app. This quick login table will only show when the app is runing under developmental environment. This is to help the developer to test its user permissions or user access to its system faster since its showing all the `User`'s attributes.

## Usage
Use the view helper in your views with a parameter of a model that uses `Devise` and the password of the user should be `password` to access the user by clicking the login button.
NOTE: This will raise an error if your model doesn't have devise included.

```erb
<html>
<!-- some html codes -->
<%= quick_login_table User %>
</html>
```

You can also use other models with devise included like:

```erb
<html>
<!-- some html codes -->
<%= quick_login_table CustomerUser %>
</html>
```

By default, it'll show all the fields except for timestamp and devise fields:
```ruby
[:encrypted_password, :reset_password_token,
:reset_password_sent_at, :remember_created_at,
:sign_in_count, :current_sign_in_ip, :last_sign_in_ip,
:current_sign_in_at, :last_sign_in_at, :created_at, :updated_at]
```

But you can customize the fields by adding the `show_fields` parameter to display the fields you wanted.

```erb
<html>
<!-- some html codes -->
<%= quick_login_table User, show_fields: [:first_name, :last_name, :age] %>
</html>
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'quick_login', git: "https://github.com/jnsoo123/quick_login.git", branch: 'develop'
```

And then execute:
```bash
$ bundle
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
