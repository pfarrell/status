require 'spec_helper'

describe 'App' do
  it "should allow access to the groups page" do
    get "/groups"
    expect(last_response).to be_ok
    expect(last_response.body).to match(/Groups/)
  end

  it "should return json for groups page" do
    get "/groups.json"
    expect(last_response).to be_ok
  end
end
