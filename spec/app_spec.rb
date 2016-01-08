require 'spec_helper'

describe 'App' do
  it "should allow access to the home page" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body) .to match(/Status/)
  end

  it 'gets statuses by id' do
    group = Group.find_or_create(name: 'groupname')
    status = Status.new(value: {test: 'status'}, group: group)
    status.save
    get "/groups/#{group.name}/status/#{status.id}"
  end

  it 'gets group statuses' do
    group = Group.find_or_create(name: 'groupname')
    status = Status.new(value: {test: 'status'}, group: group)
    status.save
    get "/groups/#{group.name}/statuses"
  end

end
