require 'spec_helper'

describe 'App' do
  let(:group) { Group.find_or_create(name: "test_group") }

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
end
