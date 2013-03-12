require 'spec_helper'

describe "textile rendering" do
  before do
    @page_model = Ecm::Cms::Page.create! do |page|
      page.pathname_en = '/'
      page.basename_en = 'foo'
      page.title_en    = 'Home'
      page.body_en     = 'h1. Home (en)'

      page.pathname_de = '/'
      page.basename_de = 'foo'
      page.title_de    = 'Home'
      page.body_de     = 'h1. Home (de)'

      page.format   = ''
      page.handler  = 'textile'
    end
  end # before

  describe "rendering the english page" do
    before do
      get "/en/foo"
    end # before

    it "should convert textile to html" do
      response.body.should include("<h1>Home (en)</h1>")
    end # it
  end # describe "rendering the english page"

  describe "rendering the german page" do
    before do
      get "/de/foo"
    end # before

    it "should convert textile to html" do
      response.body.should include("<h1>Home (de)</h1>")
    end # it
  end # describe "rendering the german page"
end # describe "textile rendering"

