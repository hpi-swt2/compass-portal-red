# Compass Portal — 🟦 Edition
`dev` branch: [![Test and deploy](https://github.com/hpi-swt2/compass-portal-blue/actions/workflows/test_and_deploy.yml/badge.svg?branch=dev)](https://github.com/hpi-swt2/compass-portal-blue/actions/workflows/test_and_deploy.yml)
[![CodeFactor](https://www.codefactor.io/repository/github/hpi-swt2/compass-portal-blue/badge)](https://www.codefactor.io/repository/github/hpi-swt2/compass-portal-blue)
[![Test Coverage](https://api.codeclimate.com/v1/badges/17a1b08229ec715e5b54/test_coverage)](https://codeclimate.com/github/hpi-swt2/compass-portal-blue/test_coverage)

`main` branch: [![Test and deploy](https://github.com/hpi-swt2/compass-portal-blue/actions/workflows/test_and_deploy.yml/badge.svg?branch=main)](https://github.com/hpi-swt2/compass-portal-blue/actions/workflows/test_and_deploy.yml)
, live app: [Heroku](https://compass-blue.herokuapp.com/)

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

A web application for finding your way, written in [Ruby on Rails](https://rubyonrails.org/).
Created in the [Scalable Software Engineering course](https://hpi.de/plattner/teaching/winter-term-2021-22/scalable-software-engineering.html) at the HPI in Potsdam.

## Development Setup
Ensure you have access to a Unix-like environment through:

* Your local Linux / MacOS installation
* Using the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install) (WSL)
* Using a VM, e.g. [Virtualbox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/)
* Using a [docker](https://docs.microsoft.com/en-us/windows/wsl/install) container

### Application Setup
* `ruby --version` Ensure Ruby v2.7.4 using [rbenv](https://github.com/rbenv/rbenv) or [RVM](http://rvm.io/)
* `sqlite3 --version` Ensure [SQLite3 database installation](https://guides.rubyonrails.org/getting_started.html#installing-sqlite3)
* `node --version; yarn --version` Ensure [Node.js and Yarn installation](https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn)
* `bundle --version` Ensure [Bundler](https://rubygems.org/gems/bundler) installation (`gem install bundler`)
* `bundle config set without 'production' && bundle install` Install gem dependencies from `Gemfile`
* `yarn install` Install JS dependencies from `package.json`
* `rails db:migrate` Setup the database, run migrations
* `rails s` Start dev server (default port _3000_ required for local [HPI OpenID Connect](https://oidc.hpi.de/))
* `bundle exec rspec --format documentation` Run the tests (using [RSpec](http://rspec.info/) framework)

## Developer Guide

### Employed Frameworks
* [Fontawesome](https://fontawesome.com/v5.15/icons) icons
* [Bootstrap](https://getbootstrap.com/docs/5.0) for layout and styling
* [Devise](https://github.com/heartcombo/devise) library for authentication
* [OmniAuth](https://github.com/omniauth/omniauth) & [OmniAuth OpenID Connect](https://github.com/m0n9oose/omniauth_openid_connect) for HPI OpenID
* [FactoryBot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#defining-factories) to generate test data
* [Capybara](https://github.com/teamcapybara/capybara#the-dsl) for feature testing
* [shoulda](https://github.com/thoughtbot/shoulda-matchers#matchers) for additional RSpec matchers

### Cheat Sheets
* [FactoryBot](https://devhints.io/factory_bot)
* [Testing using Capybara](https://devhints.io/capybara)

### Setup
* `bundle exec rails db:migrate RAILS_ENV=development && bundle exec rails db:migrate RAILS_ENV=test` Migrate both test and development databases
* `rails assets:clobber && rails webpacker:compile` Redo asset compilation

### Testing
* `bundle exec rspec` Run the full test suite
  * `--format doc` More detailed test output
  * `-e 'search keyword in test name'` Specify what tests to run dynamically
  * `--exclude-pattern "spec/features/**/*.rb"` Exclude feature tests (which are typically fairly slow)
* `bundle exec rspec spec/<rest_of_file_path>.rb` Specify a folder or test file to run
* `bundle exec rspec --profile` Examine run time of tests
* Code coverage reports are written to `coverage/index.html` after test runs (by [simplecov](https://github.com/simplecov-ruby/simplecov))

### Linting
* `rake factory_bot:lint` Create each factory and catch any exceptions raised during the creation process (defined in `lib/tasks/factory_bot.rake`)
* `bundle exec rubocop` Use the static code analyzer [RuboCop](https://github.com/rubocop-hq) to find possible issues (based on the community [Ruby style guide](https://github.com/rubocop-hq/ruby-style-guide)).
  * `--auto-correct` to fix what can be fixed automatically.
  * RuboCop's behavior can be [controlled](https://docs.rubocop.org/en/latest/configuration) using `.rubocop.yml`

### Debugging
* `console` anywhere in the code to access an interactive console
* `save_and_open_page` within a feature test to inspect the state of a webpage in a browser
* `rails c --sandbox` Test out some code in the Rails console without changing any data
* `rails dbconsole` Starts the CLI of the database you're using
* `bundle exec rails routes` Show all the routes (and their names) of the application
* `bundle exec rails about` Show stats on current Rails installation, including version numbers

### Generating
* `rails g migration DoSomething` Create migration _db/migrate/*_DoSomething.rb_
* `rails generate` takes a `--pretend` / `-p` option that shows what will be generated without changing anything

### HPI OpenID Connect Configuration
* `config/initializers/devise.rb` contains the [OmniAuth OpenID Connect](https://github.com/m0n9oose/omniauth_openid_connect) config for the HPI OIDC service
* An OpenID Connect client for `localhost:3000` is set up for local development. Additional clients registrable at [oidc.hpi.de](https://oidc.hpi.de/)
* For deployment `OPENID_CONNECT_CLIENT_ID`, `OPENID_CONNECT_CLIENT_SECRET` & `OPENID_CONNECT_REDIRECT_URI` need to be provided
* `app/controllers/users/omniauth_callbacks_controller.rb` handles data returned by the OIDC service
