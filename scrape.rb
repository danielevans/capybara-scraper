require 'rubygems'
require 'bundler/setup'
require 'json'
require 'securerandom'
require './capybara.rb'

target = "http://reddit.com/"
downloaded_images = {}

if File.exist? "downloaded.json"
  downloaded_images = JSON.parse(File.open("downloaded.json", "r").read)
end

include Capybara::DSL

visit target

fill_in "user", :with => "<username>"
fill_in "passwd", :with => "<password>"
click_button "login"

new_images = all("a").map { |a| a["href"] || a["src"] }.compact.uniq.select do |url|
  URI.parse(url).path.match(/\.(jpg|png|gif)$/) && !downloaded_images.has_key?(url) rescue false
end.map do |url|
  filename = "#{SecureRandom.hex.gsub(/=/, '')}.#{URI.parse(url).path.match(/\.(jpg|png|gif)$/)[1]}"
  `wget "#{url}" -O downloaded/#{filename}`
  downloaded_images[url] = true if $?.to_i == 0
  filename
end

File.open("downloaded.json", "wb") do |f|
  f.write downloaded_images.to_json
end

`feh -Z -F --cycle-once downloaded/#{new_images.join(' downloaded/')}` unless new_images.empty?
