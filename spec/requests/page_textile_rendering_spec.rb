require 'spec_helper'

describe "textile rendering" do
  it "converts textile to html" do
    page_model = Ecm::Cms::Page.create! do |page|
      page.pathname = '/'
      page.basename = 'foo'
      page.locale   = 'en'
      page.format   = ''
      page.handler  = 'textile'
      page.title    = 'Home'
      page.body     = 'h1. Home'
    end
    get "/en/foo"

    response.body.should include("<h1>Home</h1>")
  end
end
