source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'

gem 'pg'
gem 'octokit'
gem 'rollbar'

group :development do
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'byebug'
end

group :test do
  gem 'rspec'
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'puma'
end
