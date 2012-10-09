require 'spec_helper'
describe "home page" do
  it "displays the 'home' page content" do
    page_model = Ecm::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'home'
      page.format   = 'html'
      page.handler  = 'erb'
      page.title    = 'Home'
      page.body     = '<h1>Home</h1>'
    end
    get "/"

    response.body.should include(page_model.body)
  end
end

