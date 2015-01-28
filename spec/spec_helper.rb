require './server.rb'
require 'capybara/rspec'

ENV['RACK_ENV'] = 'test'

Capybara.app = ScrabblerApp

RSpec.configure do |config|

  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = :random

end
