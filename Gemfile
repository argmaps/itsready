source 'https://rubygems.org'
ruby '2.0.0'


gem 'rails', '4.0.0'
gem 'activerecord-postgresql-adapter', '0.0.1'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '1.3.0'
gem 'jquery-turbolinks', '1.0.0'

gem 'twilio-ruby', '3.10.1'
gem 'sorcery', :github => 'NoamB/sorcery', :ref => 'bacf0c16b82f85604ee019a45ef7728408f190d1'
gem 'simple_form', '3.0.0.beta1'
gem 'client_side_validations', :github => 'bcardarella/client_side_validations', :branch => '4-0-beta'
gem 'client_side_validations-simple_form', :github => 'joshweinstein/client_side_validations-simple_form', :branch => '2-0-stable'
gem 'request_store', '1.0.5'
gem 'browser-timezone-rails', '0.0.6'
gem 'countries', '0.9.2'
gem 'country_select', '1.2.0'

group :assets do
  gem 'sass-rails', '4.0.0'
  gem 'bootstrap-sass', '2.3.2.1'
  gem 'coffee-rails', '4.0.0'
  gem 'uglifier', '2.0.1'
  gem 'flatui-rails', :github => 'joshweinstein/flatui-rails'
end

group :development, :test do
  # Debugging gems - must be excluded from Heroku
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
end

group :production do
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
