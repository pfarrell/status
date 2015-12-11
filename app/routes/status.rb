class App < Sinatra::Application
  
  def get_status(entry, status, upsert=false)
    if(upsert)
      return Status.find_or_create(entry: entry, value: status)
    else
      return Status.new(entry: entry, value: status)
    end
  end

  post "/groups/:group/statuses" do
    content_type :json
    ret=[]
    group = Group.find_or_create(group: params[:group])
    obj = JSON.parse(request.body.read)
    obj["statuses"].each do |status|
      entry = Entry.find_or_create(group: group, name: status["name"])
      status = Status.new(entry: entry, value: status)
      status.save
      ret << status
    end
    ret.to_json
  end

  get "/groups/:group/statuses" do
    statuses=[]
    group = Group.find(group: params[:group])
    return if group.nil?
    group_lookup = params[:names].nil? ? group.entries : group.entries.select{|entry| entry.name == params[:names]}
    group_lookup.entries.each do |entry|
       statuses.concat(entry.statuses) 
    end
    statuses.to_json
  end

  get "/groups/:group/status/:id" do
    Status[:id].to_json
  end
  
end
