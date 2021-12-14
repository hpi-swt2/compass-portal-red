# BDD with cucumber and capybara

(this is not important for setup) I followed this guide to setup all necessary files for the project: https://www.agiratech.com/web-automation-testing-with-ruby-cucumber-watir

## Prerequisits
To run the integration tests, you need to install chromedriver for Selenium to communicate with your web browser.

-I followed these instructions for ubuntu 20.04: https://tecadmin.net/setup-selenium-chromedriver-on-ubuntu/



## Setup

For running the test scenarios with browser automation the following gems are needed
- rspec
- capybara
- cucumber-rails
- database_cleaner
- selenium-webdriver
- watir

All these gems are specified in Gemfile, run `bundle install` from project folder



## Run test scenarios

- All tests:
  `bundle exec cucumber`
- All scenarios in a given file or folder:
  `bundle exec cucumber features/scenarios/my_feature.feature`
- Just one scenario in a given file (specified by line):
  `bundle exec cucumber features/scenarios/my_feature.feature:10`

Default browser is chrome, if you want to change it set the environment variable `BROWSER` to another browser.
- e.g. `bundle exec cucumber BROWSER=firefox`

You can also set the environment variable `HEADLESS` to true, if you want to run in headless mode.

## Writing Tests

Features can be found in the `features/scenarios` directory. They consist of a generic description of the feature (this is a dummy feature file `my_feature.feature`),

```
Feature: Search a person
 In order to find information about a chair, room or person on HPI campus
 As a user
 I want to search it
``` 

a list of steps that should run before every scenario,

``` 
Background:
 Given an active course was created
 And I am a confirmed user
 And I am logged in
``` 

and the scenario itself

```
Scenario: search a person by name
 Given I am on the search page 
 When I enter "Michael"
 And I start the search
 Then I see the search result "Dr Michael Perscheid"   
``` 
You have to define the steps in `features/step_definitions/my_feature_steps.rb`.

You can mark Scenarios as @wip (e.g. when the feature is not yet implemented).
