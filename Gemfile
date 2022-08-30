source 'https://rubygems.org'
ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '7.0.3.1'
gem 'bigdecimal', '1.3.0'
gem 'bootstrap-sass', '~> 3.3.1'
gem 'bootstrap-social-rails'
gem 'font-awesome-rails'
gem 'autoprefixer-rails'
gem 'cocoon'
gem 'pg'
gem 'json', '2.3.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 3.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 5.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'slim-rails'
gem 'cells-rails'
gem 'cells-slim'
gem 'pg_search'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc',          group: :doc

# Spring speeds up development by keeping your application running in the
# background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-windowslive'
gem 'omniauth-rails_csrf_protection'

# use simple form
gem 'simple_form', '~> 5.1.0'

# gem 'foreigner'
gem 'pry'
# gem 'quiet_assets'

group :development, :test do
  gem 'rspec-rails', '~> 3.0.1'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'rspec-collection_matchers', '~> 1.0.0'
  gem 'cane', require: false
  gem 'rubocop', require: false
  gem 'shoulda-matchers'
  gem 'webmock', require: false
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'dotenv-rails'
end

group :test do
  gem 'capybara', '2.2.0'
  gem 'database_cleaner'
  gem 'faker', '~> 2.22.0'
  gem 'launchy', '~> 2.3.0'
  gem 'selenium-webdriver', '~> 2.39.0'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
end
