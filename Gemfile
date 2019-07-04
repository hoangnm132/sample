source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.1"

gem "rails", "~> 5.2.3"
gem "sqlite3"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "bootstrap-sass", "3.3.7"
gem "i18n", "~> 1.6"
gem "bcrypt",         "3.1.12"
gem "config"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "jquery-rails", "~> 4.3", ">= 4.3.1"
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'kaminari-bootstrap', '~> 3.0', '>= 3.0.1'
gem 'faker', '~> 1.9', '>= 1.9.5'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem 'ffaker', '~> 2.11'
end
group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
end

