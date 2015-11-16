class App < Sinatra::Application

  post "/groups/:group/statuses" do
    content_type :json
    ret=[]
    group = Group.find_or_create(group: params[:group])
    obj = JSON.parse(request.body.read)
    obj["statuses"].each do |status|
      entry = Entry.find_or_create(group: group, name: status["name"])
      status = Status.new(entry: entry, value: status["value"])
      status.save
      ret << status
    end
    ret.to_json
  end
  
end
