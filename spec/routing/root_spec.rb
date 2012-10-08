require 'spec_helper'

describe "routing to the root path" do
  it "routes / to page#respond and page 'home'" do
    expect(:get => "/").to route_to(
      :controller => "ecm/cms/page",
      :action => "respond",
      :page => "home"
    )
  end
end

