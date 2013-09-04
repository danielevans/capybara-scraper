require 'rubygems'

require './capybara.rb'

target = ENV["target"] || "http://reddit.com/r/funny"

include Capybara::DSL

visit target

save_screenshot('screenshot.png')

# `open screenshot.png`
`feh -Z -F --cycle-once screenshot.png`
