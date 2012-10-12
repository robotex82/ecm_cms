require 'spec_helper'
describe "requesting '/' redirects to the default locale" do
  it "redirects" do
    get "/"
    response.should redirect_to("/#{I18n.default_locale}")
  end
end

describe "localized home page" do
  it "displays the 'home' page content" do
    page_model = Ecm::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'home'
      page.locale   = 'en'
      page.format   = 'html'
      page.handler  = 'erb'
      page.title    = 'Home'
      page.body     = '<h1>Home</h1>'
    end
    get "/en"

    response.body.should include(page_model.body)
  end
end

