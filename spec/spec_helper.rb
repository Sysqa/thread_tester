# gem install rspec
# gem install selenium-webdriver
# gem install capybara
# gem install capybara-webkit
# sudo apt-get install libqt4-dev
# sudo apt-get install xvfb
# 
# headless version (can't see any window), but colse windows before finished tasks.
# xvfb-run rspec spec --color
# 
# or
# 
# rspec spec --color
# 
require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'net/http'
require 'test_helper'

Capybara.default_driver = :selenium
Capybara.javascript_driver = :webkit
Capybara.app_host = "http://localhost:3000"

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include TestHelper
end
