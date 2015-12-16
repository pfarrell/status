require 'json'
class JsonDoc
  attr_accessor :obj, :type, :created, :next, :prev


  def initialize(data, type)
    @obj = data
    @type = type
    @created = DateTime.now.iso8601
  end

  def to_json(opts={})
    {
      @type => @obj,
      created: @created,
      next: @next,
      prev: @prev
    }.to_json(opts)
  end
end
