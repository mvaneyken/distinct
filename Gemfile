source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'pg'
gem 'foreigner'                     # Manage foreign keys

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier'
end
gem 'quiet_assets', :group => :development

gem 'bootstrap-sass'
gem 'jquery-rails'
gem "haml-rails"

gem 'activeadmin'                   # Back Office straight 'out of the box'
gem 'meta_search', '>= 1.1.0.pre'   # Required for activeadmin
gem 'devise'                        # User authentication
gem 'high_voltage'							    # Facilitates 'static' pages
gem 'rails_config'                  # Manage settings in convenient (public vs private) fashion
gem 'simple_form'                   # Manage forms
gem "cocoon"									      # Nested models in forms
gem "transitions", ">= 0.1.1", :require => ["transitions", "active_model/transitions"]
gem 'kaminari'
gem 'bootstrap-kaminari-views'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'rspec-rails', :group => [:test, :development]
group :test do
  gem 'capybara'
  gem "database_cleaner"
  gem 'factory_girl_rails'
  gem 'fakeweb'
  gem 'launchy'
  gem 'vcr'
end

group :production do
	gem 'execjs'
	gem 'libv8'
end
gem 'therubyracer', '~> 0.10.0'
