require './poster'
require 'twitter'
require 'httparty'
require 'byebug'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["STATUS_CONSUMER_KEY"]
  config.consumer_secret     = ENV["STATUS_CONSUMER_SECRET"]
  config.access_token        = ENV["STATUS_ACCESS_TOKEN"]
  config.access_token_secret = ENV["STATUS_ACCESS_TOKEN_SECRET"]
end

tweets = client.home_timeline

poster = Poster.new
poster.group = "pattest"

tweets.each do |tweet|
  status = Status.new
  status.name = "Twitter"
  status.value["random tweet"] = tweet.text
  poster.statuses << status
end

p status.to_json

poster.save



