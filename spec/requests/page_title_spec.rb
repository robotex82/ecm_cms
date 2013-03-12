require 'spec_helper'
describe "title rendering" do
  before do
    @page_model = Ecm::Cms::Page.create! do |page|
      page.pathname_en  = '/'
      page.basename_en = 'home'
      page.title_en    = 'This is the title'
      page.body_en     = '<h1>Home</h1>'

      page.pathname_de  = '/'
      page.basename_de = 'home'
      page.title_de    = 'Dies ist der Titel'
      page.body_de     = '<h1>Home</h1>'

      page.format   = 'html'
      page.handler  = 'erb'
    end  
  end # before

  describe "english locale" do
    before do
      get "/en"
    end # before

    it "should show the correct title" do
      response.body.should include("<title>#{Ecm::Cms::Configuration.site_title} - #{@page_model.title_en}</title>")
    end # it
  end # describe "english locale"

  describe "german locale" do
    before do
      get "/de"
    end # before

    it "should show the correct title" do
      response.body.should include("<title>#{Ecm::Cms::Configuration.site_title} - #{@page_model.title_de}</title>")
    end # it
  end # describe "german locale"

end # describe "title rendering"

