require 'spec_helper'

describe "404 support" do
  it "throws a 404 for unknown pages" do
    get "/en/not-existent-page"
    response.response_code.should == 404
  end
end
