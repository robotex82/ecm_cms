require 'spec_helper'

describe "routing to the localized root path" do
  it "routes /en to page#respond and page 'home'" do
    expect(:get => "/en").to route_to(
      :i18n_locale => "en",
      :controller => "ecm/cms/page",
      :action => "respond",
      :page => "home"
    )
  end

  it "routes /de to page#respond and page 'home'" do
    expect(:get => "/de").to route_to(
      :i18n_locale => "de",
      :controller => "ecm/cms/page",
      :action => "respond",
      :page => "home"
    )
  end
end

