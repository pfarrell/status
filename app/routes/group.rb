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

  get "/groups/:group" do
    data = Group.where(group: params[:group])
    respond_to do |wants|
      wants.json { data.to_json}
      wants.html { haml :status, locals: {model: data.first}}
    end
  end

  get "/groups" do
    content_type :json
    Group.where(group: params[:group]).to_json
  end
end
