class App < Sinatra::Application
  
  def status_status_props
    props={}
    props["Group"]={value: lambda{|x|  x.entry.group.group}}
    props["Entry"]={value: lambda{|x|  x.entry.name}}
    props["Value"]={value: lambda{|x|  x.value}}
    props
  end

  def get_status(entry, status, upsert=false)
    if(upsert)
      return Status.find_or_create(entry: entry, value: status)
    else
      return Status.new(entry: entry, value: status)
    end
  end

  get "/groups/:group/statuses" do
    statuses=[]
    group = Group.find(name: params[:group])
    return if group.nil?
    respond_to do |wants|
      wants.json { JsonDoc.new(group.statuses, "statuses").to_json }
      wants.html { haml :statuses, locals: { model: { header: status_status_props, data: group.statuses}}}
    end
  end

  get "/groups/:group/status/:id" do
    Status[:id].to_json
  end
  
end
