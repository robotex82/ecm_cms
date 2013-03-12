require 'spec_helper'

describe "meta description" do
  before do
    @page_model = Ecm::Cms::Page.create! do |page|
      page.pathname_en         = '/'
      page.basename_en         = 'home'
      page.title_en            = 'Some title'
      page.meta_description_en = 'This is the meta description'
      page.body_en             = '<h1>Home (en)</h1>'

      page.pathname_de         = '/'
      page.basename_de         = 'home'
      page.title_de            = 'Seiten titel'
      page.meta_description_de = 'Dies ist die Meta-Beschreibung'
      page.body_de             = '<h1>Home (de)</h1>'

      page.format              = 'html'
      page.handler             = 'erb'
    end
  end # before

  describe "when rendering the page" do
    describe "for the english locale" do
      before do
        get "/en"
      end # before

      it "should add the meta description to the page" do
        response.body.should include("<meta name=\"description\" content=\"This is the meta description\">")
      end # it
    end # describe "for the english locale"

    describe "for the german locale" do
      before do
        get "/de"
      end # before

      it "should add the meta description to the page" do
        response.body.should include("<meta name=\"description\" content=\"Dies ist die Meta-Beschreibung\">")
      end # it
    end # describe "for the english locale"
  end # describe "when rendering the page"
end # describe "meta description"

