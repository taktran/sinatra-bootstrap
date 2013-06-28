source 'https://rubygems.org'
ruby '2.0.0'

gem 'rake'
gem 'sinatra'
gem 'thin'
gem 'sinatra-flash'
gem 'rack'

# Views
gem 'sass'
gem 'haml'

# For running on production
gem 'rspec'

group :development do
  gem 'debugger'
end

group :development, :test do
  # Servers
  gem 'shotgun'

  # Testing
  gem 'guard'
  gem 'foreman'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'guard-rspec'

  gem 'rack-test'
  gem "factory_girl", "~> 2.1.0"
  gem 'capybara'
end

