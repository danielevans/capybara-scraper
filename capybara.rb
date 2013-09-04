
# config/initializers/capybara.rb
require "capybara"
require "capybara/dsl"
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  # Capybara::Poltergeist::Driver.new(app, :js_errors => false, :phantomjs_options => ['--load-images=no', '--ignore-ssl-errors=yes'])
  Capybara::Poltergeist::Driver.new(app, :js_errors => false, :phantomjs_options => ['--ignore-ssl-errors=yes'])
end

Capybara.run_server = false
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.current_driver = :poltergeist
Capybara.default_wait_time = 5
