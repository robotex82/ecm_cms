require 'spec_helper'

describe "routing to pages" do
  it "routes /foo to ecm/cms/page#respond" do
    expect(:get => "/foo").to route_to(
      :controller => "ecm/cms/page",
      :action => "respond",
      :page => "foo"
    )
  end

  it "routes a deeply nested page to ecm/cms/page#respond" do
    expect(:get => "/this/is/a/deeply/nested/page").to route_to(
      :controller => "ecm/cms/page",
      :action => "respond",
      :page => "this/is/a/deeply/nested/page"
    )
  end
end

