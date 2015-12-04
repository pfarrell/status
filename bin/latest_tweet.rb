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

tweets = client.user_timeline("pfarrell")

status = Status.new
status.name = "Twitter"
status.value["latest tweet"] = tweets.last.text

p status.to_json

poster = Poster.new
poster.group = "pattest"
poster.statuses << status
poster.save



