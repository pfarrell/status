require 'httparty'
require 'json'

class Status
  attr_accessor :name, :value
  
  def initialize
    @value = {}
  end

  def to_json(opts={})
    {name: @name, value: @value}.to_json(opts)
  end
end

class Poster
  include HTTParty
  attr_accessor :host, :group, :statuses

  def initialize(host="http://localhost:9292")
    @host = host
    @statuses = []
  end

  def url
    "#{@host}/groups/#{@group}/statuses" 
  end

  def save
    self.class.post(url, {body: {statuses: statuses}.to_json})
  end
end
