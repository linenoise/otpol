source 'https://rubygems.org'

ruby '2.2.5'

gem 'rails', '~> 4.2.0'
gem 'rails_config'
gem 'bundler'
gem 'nokogiri', '1.6.1'

### API

gem 'sdoc', '~> 0.4.0', group: :doc

### Authentication

gem 'devise', github: 'plataformatec/devise'
gem 'binding_of_caller'
gem 'omniauth'
gem 'omniauth-facebook'
# gem 'bcrypt', '~> 3.1.7'

### Database

gem 'pg'
gem 'delayed_job_active_record'
gem 'acts_as_votable', github: 'ryanto/acts_as_votable'
gem 'validates_formatting_of'
gem 'tzinfo-data'
gem 'activeadmin', github: 'gregbell/active_admin'

### Frontend

gem 'bootstrap-sass', '3.3.5'
gem 'bootstrap-sass-extras'
gem 'simple_form'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'

### Image uploads

gem 'paperclip'
gem 'rmagick'
gem 'aws-sdk', '~> 2.3'

### JavaScript

gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
# gem 'therubyracer',  platforms: :ruby

### Development and Test Environments

group :development do
  gem 'spring'
  gem 'pry-rails'
  gem 'better_errors'
  # gem 'capistrano-rails'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'dotenv-rails'
  # gem 'debugger'
  # gem 'unicorn'
end

group :test do
  gem 'shoulda-matchers'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end