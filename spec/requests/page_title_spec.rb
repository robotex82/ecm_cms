require 'spec_helper'
describe "title rendering" do
  it "adds the title to the page" do
    page_model = Ecm::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'home'
      page.locale   = 'en'
      page.format   = 'html'
      page.handler  = 'erb'
      page.title    = 'This is the title'
      page.body     = '<h1>Home</h1>'
    end
    get "/en"

    response.body.should include("<title>#{Ecm::Cms::Configuration.site_title} - #{page_model.title}</title>")
  end
end

