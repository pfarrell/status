require 'json' 

class App < Sinatra::Application
  def make_lambdas(group)
    headers = {}
    props = {}
    group.statuses.each do |status|
      status.value.each do |k,v|
        headers[k] = nil
      end
    end
    headers.each do |k,v|
      props[k] = {value: lambda{|x| x.value[k]}}
    end
    props
  end

  def group_props
    props= {}
    props["Name"]={ value: lambda{|x| x.name}}
    props
  end

  def group_status_props(group)
    props=make_lambdas(group)
    props["Group"]={value: lambda{|x|  x.group.name}}
    props["date"] ={value: lambda{|x| x.created_at}}
    props
  end

  get "/groups" do
    data = Group.all
    respond_to do |wants|
      wants.json { data.to_json }
      wants.html { haml :groups, locals: {title: "Groups", model: {header: group_props, data: data} }}
    end
  end

  post "/groups" do
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

  get "/groups/:group_name/latest" do
    data = Group.where(name: params[:group_name])
    respond_to do |wants|
      wants.json { JsonDoc.new(data.first, "groups").to_json}
      wants.html { haml :latest, locals: {model: data.first}}
    end
  end

  get "/groups/:group_name" do
    statuses=[]
    group = Group.where(name: params[:group_name])
    return if group.count == 0
    respond_to do |wants|
      wants.json { JsonDoc.new(group, "groups").to_json }
      wants.html { haml :statuses, locals: { model: { header: group_status_props(group.first), data: group.first.statuses}}}
    end
  end
end
