class App < Sinatra::Application
  get "/" do
    data = Group.all
    respond_to do |wants|
      wants.json { JsonDoc.new(data, "groups").to_json }
      wants.html { haml :index, locals: {model: data} }
    end
  end
end
