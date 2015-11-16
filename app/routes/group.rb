require 'json' 

class App < Sinatra::Application
  def props
    ret = []
    ret << {name: "Group Name", value: lambda{|x| x.inspect }}
  end

  get "/groups" do
    date = Group.all
    respond_to do |wants|
      wants.json { data.to_json }
      wants.html { haml :list, locals: {definition: props, data: data} }
    end
  end

  post "/groups/:group" do
    data = Group.find_or_create(group: params[:group])
    respond_to do |wants|
      wants.json { group.to_json }
      wants.html { haml :list, locals: {definition: props, data: data} }
    end
  end

#  post "/groups/:group/statuses" do
#    content_type :json
#    group = Group.find_or_create(group: params[:group])
#    obj = JSON.parse(request.body.read)
#    obj["statuses"].each do |status| 
#    #require 'byebug' 
#    #byebug
#    entry = Entry.new(group: group, value: obj["status"])
#    entry.save
#    entry.to_json
#  end

  get "/groups/:group" do
    data = Group.where(group: group)
    respond_to do |wants|
      wants.json { data.to_json}
    end
  end
end
