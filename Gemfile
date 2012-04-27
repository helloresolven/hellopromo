source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'bcrypt-ruby', '~> 3.0.1'
gem 'figaro'
gem 'simple_form'
gem 'omniauth-twitter'
gem 'kramdown'
gem 'draper'
gem 'twitter'
gem 'heroku'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.9'
  gem 'rails_best_practices'
  gem 'ffaker'
  gem 'quiet_assets'
end

group :test do
  gem 'fabrication'
  gem 'shoulda-matchers'
  gem 'spork', '~> 1.0rc'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'delorean'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
end

gem 'jquery-rails'