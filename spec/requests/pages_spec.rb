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
      page.pathname_en = '/'
      page.basename_en = 'home'
      page.title_en    = 'Home'
      page.body_en     = '<h1>Home (en)</h1>'

      page.pathname_de = '/'
      page.basename_de = 'home'
      page.title_de    = 'Home'
      page.body_de     = '<h1>Home (de)/h1>'

      page.format   = 'html'
      page.handler  = 'erb'
    end
    get "/en"

    response.body.should include(page_model.body_en)
  end

  describe "requesting nested page" do
    it "requesting /foo/bar/baz should succeed" do
      page_model = Ecm::Cms::Page.create! do |page|
        page.pathname_en = '/foo/bar/'
        page.basename_en = 'baz'
        page.title_en    = 'FooBar (en)'
        page.body_en     = '<h1>Foo/Bar (en)</h1>'

        page.pathname_de = '/foo/bar/'
        page.basename_de = 'baz'
        page.title_de    = 'FooBar (de)'
        page.body_de     = '<h1>Foo/Bar (de)</h1>'

        page.format   = 'html'
        page.handler  = 'erb'
      end
      get "/en/foo/bar/baz"

      response.body.should include(page_model.body_en)
    end
  end

  describe "requesting text template" do
    it "requesting /en/test.txt should succeed" do
      page_model = Ecm::Cms::Page.create! do |page|
        page.pathname_en = '/'
        page.basename_en = 'test'
        page.title_en    = 'Test'
        page.body        = 'Example text template'

        page.pathname_de = '/'
        page.basename_de = 'test'
        page.title_de    = 'Test'
        page.body_de     = 'Beispiel Text-Template'

        page.format   = 'text'
        page.handler  = 'erb'
      end
      get "/en/test.txt"

      response.body.should include(page_model.body_en)
    end
  end
end

describe 'page with content blocks' do
  it 'should render the page block content' do
    page_model = Ecm::Cms::Page.create! do |page|
      page.pathname_en = '/'
      page.basename_en = 'test'
      page.title_en    = 'Page with content block'
      page.body_en     = 'Footer content here: <%= content_for?(:footer) ? yield(:footer) : nil %>'

      page.pathname_de = '/'
      page.basename_de = 'test'
      page.title_de    = 'Seite mit content block'
      page.body_de     = 'Footer Inhalt hier: <%= content_for?(:footer) ? yield(:footer) : nil %>'

      page.format   = 'html'
      page.handler  = 'erb'
    end

    content_box = Ecm::Cms::ContentBox.create! do |content_box|
      content_box.name = 'footer'
    end

    footer_content_block = page_model.ecm_cms_page_content_blocks.create! do |content_block|
      content_block.ecm_cms_content_box = content_box
      content_block.body = 'This is the footer content'
    end
    get "/de/test"

    response.body.should include(footer_content_block.body)
  end
end

