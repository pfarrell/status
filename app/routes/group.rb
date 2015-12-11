require 'json' 

class App < Sinatra::Application
  def group_props
    props= {}
    props["Name"]={ value: lambda{|x| x.group }}
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
      wants.json { data.first.to_json}
      wants.html { haml :latest, locals: {model: data.first}}
    end
  end

  get "/groups" do
    statuses=[]
    return if group.nil?
    group_lookup = params[:names].nil? ? group.entries : group.entries.select{|entry| entry.name == params[:names]}
    group_lookup.entries.each do |entry|
       statuses.concat(entry.statuses) 
    end
    respond_to do |wants|
      wants.json { statuses.to_json }
      wants.html { haml :statuses, locals: { model: { header: status_props, data: statuses}}}
    end
  end
end
