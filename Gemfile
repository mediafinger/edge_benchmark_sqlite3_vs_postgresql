source "https://rubygems.org"

# Use specific branch of Rails
gem "rails", github: "rails/rails", branch: "main"

gem "propshaft" # The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "sqlite3", ">= 2.1" # Use sqlite3 as the database for Active Record
gem "puma", ">= 5.0" # Use the Puma web server [https://github.com/puma/puma]
gem "importmap-rails" # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "turbo-rails" # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "stimulus-rails" # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "bcrypt", "~> 3.1.7" # Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "solid_cache" # Use the database-backed adapters for Rails.cache
gem "solid_queue" # Use the database-backed adapters for Active Job
gem "kamal", require: false # Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "thruster", require: false # Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]

group :development, :test do
  gem "brakeman", require: false # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "bundler-audit", "~> 0.9"
  gem "rspec-rails" # Use RSpec for testing [https://rspec.info/]
  gem "rubocop-rails-omakase", require: false # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
end

group :development do
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]
end
