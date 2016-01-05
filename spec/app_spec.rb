require 'spec_helper'

describe 'App' do
  it "should allow access to the home page" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body) .to match(/Status/)
  end
end
