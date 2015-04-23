require 'spec_helper'

describe "routing to pages" do
  # routes { Ecm::Cms::Engine.routes }

  it "routes /foo to ecm/cms/page#respond" do
    expect(:get => "/en/foo").to route_to(
      :i18n_locale => "en",
      :controller => "ecm/cms/page",
      :action => "respond",
      :page => "foo"
    )
  end

  it "routes a deeply nested page to ecm/cms/page#respond" do
    expect(:get => "/en/this/is/a/deeply/nested/page").to route_to(
      :i18n_locale => "en",
      :controller => "ecm/cms/page",
      :action => "respond",
      :page => "this/is/a/deeply/nested/page"
    )
  end
end

