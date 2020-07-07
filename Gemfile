# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.2.4'
gem 'rails-html-sanitizer', '~> 1.0.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'slim-rails', '~> 3.1'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  # test coverage with coveralls
  gem 'coveralls', require: false
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'faker', '~> 1.8.4'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.7'
  gem 'rubocop', '~> 0.52.0', require: false
  # gem 'rubocop-rails', '~> 1.1.1', require: false
  gem 'rubocop-rspec', '~> 1.16.0', require: false
  gem 'puma', '~> 3.7'
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'mysql2', '>= 0.3.18', '< 0.5'
end

###

gem 'canister'
gem 'ettin'

# Even though KCV requires these gems, if they are not in the Gemfile, we can't
# use the bundle config local.GEMNAME mechanism for testing from local disk.
gem 'keycard',    '~> 0.3', github: 'mlibrary/keycard'
gem 'checkpoint', '~> 1.1', github: 'mlibrary/checkpoint'
gem 'vizier',     '~> 0.1', github: 'mlibrary/vizier'
gem 'kcv',        '~> 0.4.1', github: 'mlibrary/kcv'
