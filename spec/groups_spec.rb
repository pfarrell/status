require 'spec_helper'
require 'json'

describe 'App' do
  let(:group) { Group.find_or_create(name: "test_group") }

  let(:status) { Status.new(group: group, value: {"test_key"=>"test_val"}.to_json) } 

  it "should allow access to the groups page" do
    get "/groups"
    expect(last_response).to be_ok
    expect(last_response.body).to match(/Groups/)
  end

  it "should return json for groups page" do
    get "/groups.json"
    expect(last_response).to be_ok
  end

  it "should return latest statuses" do
    get "/groups/#{group.name}/latest"
    expect(last_response).to be_ok
  end

  it "should return latest statuses in json format" do
    get "/groups/#{group.name}/latest.json"
    expect(last_response).to be_ok
  end

  it "should return all statuses for a group" do
    status.save
    get "/groups/#{group.name}"
    expect(last_response).to be_ok
  end
  
  it "should return all statuses for a group in json format" do
    get "/groups/#{group.name}.json"
    expect(last_response).to be_ok
  end

  it "allows you to post statuses at it" do
    post "/groups", {statuses: [{name: "#{group.name}", value: {"test_key"=> "test_val"}}]}.to_json
    expect(last_response).to be_ok
  end
end
